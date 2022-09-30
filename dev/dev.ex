defmodule Dev do
  @moduledoc false

  # https://github.com/hexpm/hexpm/pull/1133/files

  def aws_access_key_id, do: System.fetch_env!("AWS_ACCESS_KEY_ID")
  def aws_secret_access_key, do: System.fetch_env!("AWS_SECRET_ACCESS_KEY")
  def aws_region, do: System.get_env("AWS_REGION") || "eu-north-1"

  def ruslan_gmail, do: System.fetch_env!("RUSLAN_GMAIL")
  def domain, do: System.fetch_env!("DOMAIN")

  def aws_client do
    %AWS.Client{
      access_key_id: aws_access_key_id(),
      secret_access_key: aws_secret_access_key(),
      region: aws_region(),
      http_client: {AWS.FinchClient, []}
    }
  end

  def aws_ses_account do
    {:ok, response, %{status_code: 200}} = AWS.SESv2.get_account(aws_client())
    response
  end

  def aws_ses_blacklist_reports do
    AWS.SESv2.get_blacklist_reports(aws_client(), "")
  end

  def aws_ses_email_identity do
    AWS.SESv2.get_email_identity(aws_client(), domain)
  end

  def aws_send_email do
    AWS.SESv2.send_email(aws_client(), %{
      "FromEmailAddress" => "Ruslan <ruslan@#{domain()}>",
      "Destination" => %{
        "ToAddresses" => [ruslan_gmail()]
      },
      "Content" => %{
        "Simple" => %{
          "Subject" => %{
            "Charset" => "UTF-8",
            "Data" => "тест сабжект test subject"
          },
          "Body" => %{
            "Text" => %{
              "Charset" => "UTF-8",
              "Data" => "тест тело test body"
            }
          }
        }
      }
    })
  end
end

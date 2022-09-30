defmodule AWS.SESv2 do
  @moduledoc """
  Amazon SES API v2

  [Amazon SES](http://aws.amazon.com/ses) is an Amazon Web Services service that you can use to send email messages to your customers.

  If you're new to Amazon SES API v2, you might find it helpful to review the
  [Amazon Simple Email Service Developer
  Guide](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/). The *Amazon SES
  Developer Guide* provides information and code samples that demonstrate how to
  use Amazon SES API v2 features programmatically.
  """

  alias AWS.Request

  def metadata do
    %{
      abbreviation: nil,
      api_version: "2019-09-27",
      content_type: "application/x-amz-json-1.1",
      credential_scope: nil,
      endpoint_prefix: "email",
      global?: false,
      protocol: "rest-json",
      service_id: "SESv2",
      signature_version: "v4",
      signing_name: "ses",
      target_prefix: nil
    }
  end

  @doc """
  Obtain information about the email-sending status and capabilities of your
  Amazon SES account in the current Amazon Web Services Region.
  """
  def get_account(client, options \\ []) do
    url_path = "/v2/email/account"
    headers = []
    query_params = []

    meta = metadata()

    Request.request_rest(client, meta, :get, url_path, query_params, headers, nil, options, nil)
  end

  @doc """
  Retrieve a list of the blacklists that your dedicated IP addresses appear on.
  """
  def get_blacklist_reports(client, blacklist_item_names, options \\ []) do
    url_path = "/v2/email/deliverability-dashboard/blacklist-report"
    headers = []
    query_params = []

    query_params =
      if !is_nil(blacklist_item_names) do
        [{"BlacklistItemNames", blacklist_item_names} | query_params]
      else
        query_params
      end

    meta = metadata()

    Request.request_rest(client, meta, :get, url_path, query_params, headers, nil, options, nil)
  end

  @doc """
  Provides information about a specific identity, including the identity's
  verification status, sending authorization policies, its DKIM authentication
  status, and its custom Mail-From settings.
  """
  def get_email_identity(client, email_identity, options \\ []) do
    url_path = "/v2/email/identities/#{AWS.Util.encode_uri(email_identity)}"
    headers = []
    query_params = []

    meta = metadata()

    Request.request_rest(client, meta, :get, url_path, query_params, headers, nil, options, nil)
  end

  @doc """
  Sends an email message.

  You can use the Amazon SES API v2 to send the following types of messages:

    * **Simple** – A standard email message. When you create this type
  of message, you specify the sender, the recipient, and the message body, and
  Amazon SES assembles the message for you.

    * **Raw** – A raw, MIME-formatted email message. When you send this
  type of email, you have to specify all of the message headers, as well as the
  message body. You can use this message type to send messages that contain
  attachments. The message that you specify has to be a valid MIME message.

    * **Templated** – A message that contains personalization tags. When
  you send this type of email, Amazon SES API v2 automatically replaces the tags
  with values that you specify.
  """
  def send_email(client, input, options \\ []) do
    url_path = "/v2/email/outbound-emails"
    headers = []
    query_params = []

    meta = metadata()

    Request.request_rest(
      client,
      meta,
      :post,
      url_path,
      query_params,
      headers,
      input,
      options,
      nil
    )
  end
end

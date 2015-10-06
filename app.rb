require 'bundler'
Bundler.require

get '/' do
  "Asere"
end

post '/mira' do
  content_type :json

  logger.info "#{params}"

  @body = params['Body'] || "Asere ponte pa la cosa"
  @image = params['MediaUrl0']

  @bot_payload = {
    text: @body,
    channel: "#botdev",
    unfurl_links: true,
    attachments: {
      fallback: "deja el drama",
      color: "#D00000",
      image_url: @image
    }
  }

  logger.info @bot_payload

  @to_slack = HTTParty.post(ENV['SLACK_HOOK'], { 
    :body => @bot_payload.to_json,
    :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
  })

  logger.info @to_slack

  @resp = {
    meta: {
      code: 200
    }
  }

  @resp.to_json
end
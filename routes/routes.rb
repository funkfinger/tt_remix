
class TtApp < Sinatra::Base

  post '/api/v1/im' do
    halt 500, 'API error - from number required' if params['From'].blank?
    halt 500, 'API error - text required' if params['Text'].blank?
    phone = Phone.first_or_create(:number => params['From'])
    halt 500, 'API error - failed to save' unless phone.save
    im = phone.incoming_messages.new(:raw => params, :text => params['Text'])
    halt 500, 'API error - failed to save incoming message' unless im.save
    mg = MessageGroup.first(:keyword => get_keyword(im.text))
    halt 200, "{'ok': 'true'}" if mg.blank?
    mg.phones << phone if mg
    halt 500, 'API error - failed to add to message group' unless mg.save
    "{'ok': 'true'}"
  end

end
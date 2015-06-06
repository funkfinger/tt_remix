
class TtApp < Sinatra::Base

  post '/api/v1/im' do
    halt 500, 'API error - from number required' if params['From'].blank?
    halt 500, 'API error - text required' if params['Text'].blank?
    phone = Phone.first_or_create(:number => params['From'])
    halt 500, 'API error - failed to save' unless phone.save
    phone.incoming_messages.new(:raw => params, :text => params['Text'])
    phone.save
    'ok'
  end

end
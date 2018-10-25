class SensoresChannel < ApplicationCable::Channel  
    def subscribed
        stream_from 'sensores'
    end
    
    def unsubscribed
        # Any cleanup needed when channel is unsubscribed
    end
end
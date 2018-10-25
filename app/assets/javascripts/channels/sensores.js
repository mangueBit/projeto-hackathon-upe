//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

App.messages = App.cable.subscriptions.create('SensoresChannel', {  
  received: function(data) {
    console.log(data)
  },

  connected: function() {
    console.log("conected into websocket")
  },

  disconnected: function() {
      console.log("disconnected from websocket")
  },
});
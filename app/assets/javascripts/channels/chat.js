(function() {
  jQuery(document).on('turbolinks:load', function() {
    var messages;
    $("#msg").focus();
    messages = $("#messages").attr('data-team-id');
    if(App.chat){
      App.cable.subscriptions.remove(App.chat);
    }
      if ($(".teams.show").length > 0)
        
         App.chat = App.cable.subscriptions.create({
            channel: "ChatChannel",
            id: messages 
          }, 

      {
        received: function(data) 
        {
          return $('#messages').append(data['message']);
        },
        speak: function(message, team_id) 
        {
          return this.perform('speak', {
            message: message,
            team_id: team_id
          });
        }
      }, 
      );
  });

      $(document).on('keypress', function(event) {
        var message, team_id;
        team_id = $("#msg").attr('data-value');
        message = $("#msg").val();
       	if (event.keyCode === 13) {
       	 	App.chat.speak(message, team_id);
          event.target.value = '';
          return event.preventDefault();
        }
      });
}).call(this);

  $("btn").click(function(){
    var message, team_id;
      team_id = $("#msg").attr('data-value');
      message = $("#msg").val();
      if (event.keyCode === 13) {
        App.chat.speak(message, team_id);
        event.target.value = '';
        return event.preventDefault();
      }
  }).call(this);


  
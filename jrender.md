How to use jrender

create div to be replaced
create method to be called
create route to hit method
create link to trigger method remotely
create js to be triggered
create partial to be shown


VIEWS

index.html -

  <div class='replace_me'
    <p> this will be relaced </p>
  </div>


<%= link_to 'Trigger Jrender', trigger_jrender(params: 'item'), remote: true %>

_trigger_jrender.html.erb
<div>
  <% @params.each do |item| %>
    <p> <%= item %> </p>
  <% end %>
</div>


trigger_jrender.js.erb
$('.replace_me').html("<%= j render('trigger_jrender') %>")



CONTROLLER -
class Post
  def  trigger_jrender
  @params = params[:item]
    respond_to do |format|
     format.js
    end
  end
end


ROUTE
post 'post/trigger_jrender' => "post/trigger_jrender"



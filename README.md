# sparta-devise-asset-pipeline

application demonstrating linking routes, with the devise gem to handle user accounts.

## Navbar
```ERB
  <ul class="nav navbar-nav">
    <li class="active"><%= link_to 'Games', games_path %></li>
    <li><%= link_to 'New Game', new_game_path %></li>
  </ul>
  <ul class="nav navbar-nav navbar-right">
    <% if user_signed_in? %>
    <li>Logged in as: <%= current_user.email %></li>
    <li>Username: <%= current_user.username %></li>

    <li><%= link_to 'Edit Profile', edit_user_registration_path %></li>
    <li><%= link_to 'Logout', destroy_user_session_path, method: :delete %></li>
    <% else %>
    <li><%= link_to 'Sign up', new_user_registration_path %></li>
    <li><%= link_to 'Log in', new_user_session_path %></li>

    <% end %>
  </ul>
```
demonstrates how to link to certain pages within the navbar.

## Controller
```ruby
  def game_params
    params.require(:game).permit(:name,:summary,:release_date,:rating,:user_id)
  end
```
defines parameters to be accepted from form submission
```ruby
  def index
    if current_user
      @games = current_user.games
    else
      @games = []
    end
  end
```
makes database accessible in the index
```ruby
  def create
    @game = Game.new(game_params)
    @game.user = current_user

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end
```
autofills the user when creating a new game

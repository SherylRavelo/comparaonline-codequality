# This class is used for logins
class User
  attr_reader :sessions, :users, :passwords

  # Receives a hash with usernames as keys and passwords as values
  def initialize(hash)
    @sessions = []
    @users = []
    @passwords = []
    hash.map do |k,v|
      @users = @users + [k]
      @passwords = @passwords + [v]
    end
  end

  def logout(user)
    sessions.each_with_index do |session, i|
      sessions[i] = nil if session == user
    end
    sessions.compact!
  end

  # Checks if user exists
  def user_exists(user)
    # Temp variable for storing the user if found
    temp = ''
    for i in users
      if i == user
        temp = user
      end
    end
    exists = temp != '' && temp == user
    exists
  end

  # Register user
  def register_user(user, password)
    last_index = users.size
    users[last_index] = user
    passwords[last_index] = password
  end

  def remove_user(user)
	index = users.find_index(user)
    users[index] = nil
    passwords[index] = nil
    users.compact!
    passwords.compact!
  end

  def check_password(user, password)
	index = users.find_index(user)
    password_correct = passwords[index] == password
    return password_correct
  end

  def update_password(user, old_password, new_password)
    # Check if the user exists    
	if user_exists(user)
	  index = users.find_index(user)
      if passwords[index] == old_password
        passwords[index] = new_password
        return true
      end
    end
    return false
  end

  def login(user, password)
	index = users.find_index(user)
    if passwords[index] == password
      sessions << user
    end
  end
end



registered_users = {
  'user1' => 'pass1',
  'user2' => 'pass2',
  'user3' => 'pass3'
}

user = User.new(registered_users)

user.register_user('user4', 'pass4');
user.login('user4', 'pass4');
user.update_password('user3', 'pass3', 'pass5');
user.login('user3', 'pass5');
user.logout('user4');
user.logout('user3');

#puts registered_users

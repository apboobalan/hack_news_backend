defmodule HackNewsBackend.UserTest do
  use HackNewsBackend.DataCase, async: true
  alias HackNewsBackend.{Repo, User}

  describe "create_user/1" do
    test "create user" do
      user_params = %{"name" => "Booda", "email" => "booda@booda.com", "password" => "aaa"}

      User.create_user(user_params)

      user = User |> Repo.get_by!(name: user_params["name"])

      assert user.name == user_params["name"]
      assert user.email == user_params["email"]
    end
  end
end

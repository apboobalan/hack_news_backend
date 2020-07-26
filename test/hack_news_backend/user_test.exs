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

    test "validate the presence of :name, :email, :password" do
      user_params = %{}

      changeset = %User{} |> User.changeset(user_params)

      assert "can't be blank" in errors_on(changeset).name
      assert "can't be blank" in errors_on(changeset).email
      assert "can't be blank" in errors_on(changeset).password
    end

    test "validate the implicit creation of :password_hash" do
      user_params = %{"name" => "Booda", "email" => "booda@booda.com", "password" => "aaa"}

      changeset = %User{} |> User.changeset(user_params)

      assert changeset.changes.password_hash
    end

    test "validate email length and format" do
      user_params = %{"email" => "a"}

      changeset = %User{} |> User.changeset(user_params)

      assert "should be at least 5 character(s)" in errors_on(changeset).email
    end

    test "validate email format" do
      user_params = %{"email" => "aaaaa"}

      changeset = %User{} |> User.changeset(user_params)

      assert "has invalid format" in errors_on(changeset).email
    end
  end

  describe "find_and_validate_password/2" do
    test "return user after validation" do
      user_params = %{"name" => "Booda", "email" => "booda@booda.com", "password" => "aaa"}

      User.create_user(user_params)

      {:ok, user} = User.find_and_validate_password(user_params["email"], user_params["password"])

      assert user.name == user_params["name"]
      assert user.email == user_params["email"]
    end

    test "return error when the user is not found or password is not valid" do
      user_params = %{"name" => "Booda", "email" => "booda@booda.com", "password" => "aaa"}

      User.create_user(user_params)

      {:error, :invalid} = User.find_and_validate_password("some other mail", user_params["password"])
    end
  end
end

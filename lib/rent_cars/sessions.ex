defmodule RentCars.Sessions do
  alias RentCars.Accounts.User
  alias RentCars.Repo
  alias RentCars.Shared.Tokenr

  @error_invalid_credentials {:error, "Email or password is incorrect"}

  def create(email, password) do
    User
    |> Repo.get_by(email: email)
    |> check_user_exist()
    |> validate_password(password)
  end

  def check_user_exist(nil), do: @error_invalid_credentials
  def check_user_exist(user), do: user

  defp validate_password({:error, _} = err, _password), do: err

  defp validate_password(user, password) do
    if Argon2.verify_pass(password, user.password_hash) do
      token = Tokenr.generate_auth_token(user)
      {:ok, user, token}
    else
      @error_invalid_credentials
    end
  end
end

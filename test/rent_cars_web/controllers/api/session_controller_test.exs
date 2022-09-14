defmodule RentCarsWeb.Api.SessionControllerTest do
  use RentCarsWeb.ConnCase
  alias RentCars.Shared.Tokenr

  test "throw an error when user is not authenticated", %{conn: conn} do
    conn =
      post(
        conn,
        Routes.api_session_path(conn, :me, token: "dsfdsfsd")
      )

    assert json_response(conn, 400)["message"] == "invalid"
  end

  describe "handle with sessions" do
    setup :include_normal_user_token

    test "create session", %{conn: conn, user: user, password: password} do
      conn =
        post(
          conn,
          Routes.api_session_path(conn, :create, email: user.email, password: password)
        )

      assert json_response(conn, 201)["data"]["user"]["data"]["email"] == user.email
    end

    test "get me", %{conn: conn, user: user, token: token} do
      conn =
        post(
          conn,
          Routes.api_session_path(conn, :me, token: token)
        )

      assert json_response(conn, 200)["data"]["user"]["data"]["email"] == user.email
    end

    test "reset_password", %{conn: conn, user: user} do
      token = Tokenr.generate_forgot_email_token(user)

      conn =
        post(
          conn,
          Routes.api_session_path(conn, :reset_password,
            token: token,
            user: %{password: "adm@elxpro.coM1", password_confirmation: "adm@elxpro.coM1"}
          )
        )

      assert json_response(conn, 200)["data"]["user"]["data"]["email"] == user.email
    end

    test "throw error when try to reset_password", %{conn: conn} do
      conn =
        post(
          conn,
          Routes.api_session_path(conn, :reset_password,
            token: "fddsfs",
            user: %{password: "adm@elxpro.coM1", password_confirmation: "adm@elxpro.coM1"}
          )
        )

      assert json_response(conn, 400)["message"] == "Invalid token"
    end

    test "forgot password", %{conn: conn, user: user} do
      conn =
        post(
          conn,
          Routes.api_session_path(conn, :forgot_password, email: user.email)
        )

      assert response(conn, 204) == ""
    end
  end
end

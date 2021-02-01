defmodule Erlef.AccountsTest do
  use ExUnit.Case, async: true

  alias Erlef.Accounts

  test "get_member/1" do
    {:ok, _member} = Accounts.get_member("basic_member")
    {:error, :not_found} = Accounts.get_member("does_not_exist")
  end

  test "build_member/1" do
    {:ok, contact} = Erlef.Test.WildApricot.get_contact("admin")
    assert %Accounts.Member{} = Accounts.build_member(contact)
    assert %Accounts.Member{} = Accounts.build_member(%{})
  end

  test "update_member/2" do
    {:ok, %Accounts.Member{} = member} = Accounts.get_member("basic_member")

    uuid = Ecto.UUID.generate()

    {:ok, %Accounts.Member{} = member} = Accounts.update_member(member, %{id: uuid})

    assert member.id == uuid
  end
end

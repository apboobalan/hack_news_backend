defmodule HackNewsBackend.Factory do
  use ExMachina.Ecto, repo: HackNewsBackend.Repo
  alias HackNewsBackend.HackNewsBackend
  def challenge_factory do
    %HackNewsBackend.Challenge{
      title: sequence(:title, &"challenge #{&1}"),
      description: sequence(:description, &"challenge #{&1} description")
    }
  end
end

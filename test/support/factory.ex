defmodule HackNewsBackend.Factory do
  use ExMachina.Ecto, repo: HackNewsBackend.Repo
  alias HackNewsBackend.HackNewsBackend

  def challenge_factory do
    %HackNewsBackend.Challenge{
      title: sequence(:title, &"challenge #{&1}"),
      description: sequence(:description, &"challenge #{&1} description"),
      tags: build_pair(:tag)
    }
  end

  def tag_factory do
    %HackNewsBackend.Tag{
      name: sequence(:name, &"tag #{&1}")
    }
  end
end

defmodule HackNewsBackend.Factory do
  use ExMachina.Ecto, repo: HackNewsBackend.Repo

  def challenge_factory do
    %HackNewsBackend.HackNewsBackend.Challenge{
      title: sequence(:title, &"challenge #{&1}"),
      description: sequence(:description, &"challenge #{&1} description"),
      tags: build_pair(:tag)
    }
  end

  def tag_factory do
    %HackNewsBackend.HackNewsBackend.Tag{
      name: sequence(:name, &"tag #{&1}")
    }
  end

  def team_factory do
    %HackNewsBackend.HackNewsBackend.Team{
      name: sequence(:name, &"team_name #{&1}"),
      challenge: build(:challenge)
    }
  end

end

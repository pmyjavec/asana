alias Asana.Repo
alias Asana.Pose

# Script for populating the database. You can run this script as:
#
#     mix run priv/repo/seeds.exs
#
case Repo.all(Pose) do
  [] ->
    IO.puts "Seeding, nothing found"
  _ ->
    IO.puts "Not seeding, DB already populated"
    exit(:shutdown)
end

for pose <- [
  %Pose{
    name: "Headstand",
    description: "Excellent for the lymph nodes and brain, not for beginners!",
    difficulty_rating: 4,
    keywords: "headache head sinus cold flu fatigue concentration sinusitis congestion"
 },
 %Pose{
    name: "Boat",
    description: "Core strengthening, helps with balance and stamina.",
    difficulty_rating: 1,
    keywords: "stamina strength core back"
 },
 %Pose{
    name: "Plow",
    description: "An excellent stretch for the back, always approach this pose gently",
    difficulty_rating: 2.5,
    keywords: "insomnia back pain upper lower"
  },
 %Pose{
    name: "Pigeon",
    description: "A good pose for opening the hips",
    difficulty_rating: 1.5,
    keywords: "hips hamstrings knees buttocks back"
  },
  %Pose{
    name: "Warrior",
    description: "A good endurance building pose, good for stimulating the immune system",
    difficulty_rating: 1,
    keywords: "cold flu"
  },
  %Pose{
    name: "Corpse",
    description: "A relaxing, rejuvenating pose. Very good if the body is run down or one is fatuged or stressed",
    difficulty_rating: 1,
    keywords: "fatigue insomnia depression stress cold flu"
  },
  %Pose{
    name: "Standing Forward Bend",
    description: "Calming pose which is excellent for tight hamstrings",
    difficulty_rating: 1.5,
    keywords: "fatigue insomnia depression stress"
  }
] do
  Repo.insert!(pose)
end

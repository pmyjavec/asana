alias Asana.Repo
alias Asana.Pose

# Script for populating the database. You can run this script as:
#
#     mix run priv/repo/seeds.exs
#

for pose <- [
  %Pose{
    name: "Headstand",
    description: "Excellent for the lymph nodes and brain, not for beginners!",
    difficulty_rating: 4,
    keywords: "headache sinus cold flu fatigue concentration"
 },
 %Pose{
    name: "Boat",
    description: "Core strengthening, helps with balance and stamina.",
    difficulty_rating: 1,
    keywords: "back pain lower stamina strength core"
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
    keywords: "hips hamstrings back pain"
  },
  %Pose{
    name: "Warrior",
    description: "A good endurance building pose, good for stimulating the immune system",
    difficulty_rating: 1,
    keywords: "cold flu"
  }
] do
  Repo.insert!(pose)
end

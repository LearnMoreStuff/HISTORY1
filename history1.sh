#!/bin/bash

ask_question() {
  local level=$1
  local questions=()
  local correct_answer user_answer

  # Define questions by level
  declare -A questions_by_level=(
    ["1:Who was the first President of the United States?"]="George Washington"
    ["1:In which year did the Titanic sink?"]="1912"
    ["1:Who discovered America?"]="Christopher Columbus"
    ["1:What is the capital of France?"]="Paris"
    ["1:Who wrote the play 'Romeo and Juliet'?"]="William Shakespeare"
    
    ["2:Who was the British Prime Minister during World War II?"]="Winston Churchill"
    ["2:In which year did the Berlin Wall fall?"]="1989"
    ["2:Who was the first man to step on the moon?"]="Neil Armstrong"
    ["2:Which country was the first to grant women the right to vote?"]="New Zealand"
    ["2:What was the ancient Egyptian writing system called?"]="Hieroglyphics"

    ["3:Who was the Roman god of war?"]="Mars"
    ["3:What year did the French Revolution begin?"]="1789"
    ["3:Who was the longest-reigning British monarch before Queen Elizabeth II?"]="Queen Victoria"
    ["3:Who was the main author of the Declaration of Independence?"]="Thomas Jefferson"
    ["3:What empire was ruled by Genghis Khan?"]="The Mongol Empire"

    ["4:In what year did the Soviet Union collapse?"]="1991"
    ["4:Who was the last emperor of China?"]="Puyi"
    ["4:What treaty ended World War I?"]="Treaty of Versailles"
    ["4:What was the codename for the Battle of Normandy?"]="Operation Overlord"
    ["4:Which ancient civilization built Machu Picchu?"]="The Inca"
  )

  # Use mapfile to store questions that match the chosen level
  mapfile -t questions < <(for key in "${!questions_by_level[@]}"; do [[ $key == "$level:"* ]] && echo "${key#*:}"; done)

  for i in {1..5}; do
    question="${questions[RANDOM % ${#questions[@]}]}"
    correct_answer="${questions_by_level[$level:$question]}"

    read -r -p "Question $i: $question " user_answer

    if [[ "$user_answer" == "$correct_answer" ]]; then
      echo "Correct! Well done!"
    else
      echo "Incorrect. The correct answer is $correct_answer."
    fi
  done
}

main() {
  echo "Welcome to the history quiz!"
  echo "Please pick a level:"
  echo "1. Basic History"
  echo "2. Intermediate History"
  echo "3. Advanced History"
  echo "4. Expert History"

  read -r -p "Enter the level number you want to attempt: " level

  if [[ $level =~ ^[1-4]$ ]]; then
    echo -e "\nYou have chosen Level $level. You will be asked 5 questions."
    ask_question "$level"
  else
    echo "Invalid level selected. Exiting."
  fi
}

main


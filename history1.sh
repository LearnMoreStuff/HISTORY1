#!/bin/bash

ask_question() {
  local level=$1
  local questions
  local correct_answer user_answer

  declare -A level1_questions=(
    ["Who was the first President of the United States?"]="George Washington"
    ["In which year did the Titanic sink?"]="1912"
    ["Who discovered America?"]="Christopher Columbus"
    ["What is the capital of France?"]="Paris"
    ["Who wrote the play 'Romeo and Juliet'?"]="William Shakespeare"
  )

  declare -A level2_questions=(
    ["Who was the British Prime Minister during World War II?"]="Winston Churchill"
    ["In which year did the Berlin Wall fall?"]="1989"
    ["Who was the first man to step on the moon?"]="Neil Armstrong"
    ["Which country was the first to grant women the right to vote?"]="New Zealand"
    ["What was the ancient Egyptian writing system called?"]="Hieroglyphics"
  )

  declare -A level3_questions=(
    ["Who was the Roman god of war?"]="Mars"
    ["What year did the French Revolution begin?"]="1789"
    ["Who was the longest-reigning British monarch before Queen Elizabeth II?"]="Queen Victoria"
    ["Who was the main author of the Declaration of Independence?"]="Thomas Jefferson"
    ["What empire was ruled by Genghis Khan?"]="The Mongol Empire"
  )

  declare -A level4_questions=(
    ["In what year did the Soviet Union collapse?"]="1991"
    ["Who was the last emperor of China?"]="Puyi"
    ["What treaty ended World War I?"]="Treaty of Versailles"
    ["What was the codename for the Battle of Normandy?"]="Operation Overlord"
    ["Which ancient civilization built Machu Picchu?"]="The Inca"
  )

  case $level in
    1) questions=("${!level1_questions[@]}") ;;
    2) questions=("${!level2_questions[@]}") ;;
    3) questions=("${!level3_questions[@]}") ;;
    4) questions=("${!level4_questions[@]}") ;;
    *)
      echo "Invalid level."
      return 1
      ;;
  esac

  for i in {1..5}; do
    question=${questions[RANDOM % ${#questions[@]}]}
    correct_answer=${level1_questions[$question]}

    case $level in
      2) correct_answer=${level2_questions[$question]} ;;
      3) correct_answer=${level3_questions[$question]} ;;
      4) correct_answer=${level4_questions[$question]} ;;
    esac

    read -p "Question $i: $question " user_answer

    if [[ "$user_answer" == "$correct_answer" ]]; then
      echo "Correct! Well done!"
    else
      echo "Incorrect. The correct answer is $correct_answer."
    fi
  done

  return 0
}

main() {
  echo "Welcome to the history quiz!"
  echo "Please pick a level:"
  echo "1. Basic History"
  echo "2. Intermediate History"
  echo "3. Advanced History"
  echo "4. Expert History"

  read -p "Enter the level number you want to attempt: " level

  case $level in
    1|2|3|4)
      echo -e "\nYou have chosen Level $level. You will be asked 5 questions."
      ask_question $level
      ;;
    *)
      echo "Invalid level selected. Exiting."
      ;;
  esac
}

main

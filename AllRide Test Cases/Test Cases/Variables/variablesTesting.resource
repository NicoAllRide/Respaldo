name: Run Robot Framework Tests and Send Email

on:
  repository_dispatch:
    types: [trigger-workflow]
  workflow_dispatch:  # Permite la ejecución manual

concurrency:
  group: regression-tests-stage-concurrency-group
  cancel-in-progress: true

env:
  SLACK_TOKEN: ${{ secrets.SLACK_TOKEN }}
  TOKEN_ADMIN: ${{ secrets.TOKEN_ADMIN }}
  TOKEN_NICO: ${{ secrets.TOKEN_NICO }}
  TOKEN_PEDRO: ${{ secrets.TOKEN_PEDRO }}
  TOKEN_KRATOS: ${{ secrets.TOKEN_KRATOS }}
  TOKEN_NARUTO: ${{ secrets.TOKEN_NARUTO }}
  TZ: America/Santiago

jobs:
  set_timezone:
    name: Set Timezone
    runs-on: ubuntu-20.04
    steps:
      - name: Set Timezone
        uses: szenius/set-timezone@v2.0
        with:
          timezoneLinux: "America/Santiago"
          timezoneMacos: "America/Santiago"
          timezoneWindows: "America/Santiago"
          
  run_tests_and_send_email:
    name: Run Robot Framework Tests and Send Email
    runs-on: ubuntu-20.04
    needs: set_timezone
    env:
      ACTIONS_RUNNER_DEBUG: true

    steps:
      - name: Checkout code
        uses: actions/checkout@v2
        with:
          fetch-depth: 0  # Obtiene el historial de todas las ramas
          ref: main  # Asegura obtener el último commit de la rama main

      - name: Ensure latest code
        run: |
          git fetch origin main
          git reset --hard origin/main

      - name: Sleep for 20 seconds
        run: sleep 20

      - name: Setup Python and pip
        uses: actions/setup-python@v2
        with:
          python-version: 3.8
          pip-version: latest

      - name: Install dependencies
        run: |
          pip install robotframework
          pip install robotframework-requests
          pip install robotframework-seleniumlibrary
          pip install rpaframework
          pip install requests
          pip install slack_sdk

      - name: Run Robot Framework tests RDD Flow
        run: |
          robot -d results -o output_rdd.xml "AllRide Test Cases/Test Cases/RDD Flow"
        continue-on-error: true
        
      - name: Sleep for 20 seconds
        run: sleep 20

      - name: Run Robot Framework tests Regular Flow
        run: |
          robot -d results -o output_regular.xml "AllRide Test Cases/Test Cases/Regular Flow"
        continue-on-error: true

      - name: Sleep for 20 seconds
        run: sleep 20

      - name: Run Robot Framework tests Scheduled
        run: |
          robot -d results -o output_scheduled.xml "AllRide Test Cases/Test Cases/Scheduled Flow/ScheduledTickets"
        continue-on-error: true


      - name: Fuse outputs
        run: rebot --output output.xml results/output_rdd.xml results/output_regular.xml results/output_scheduled.xml
        continue-on-error: true
        
      - name: Commit Log File
        run: |
          cd /home/runner/work/Stage-Automation-Tests/Stage-Automation-Tests
          git config --global user.email nicolas@allrideapp.com
          git config --global user.name NicoAllRide
          git add log.html
          git add output.xml
          git commit -m "Add log file and Output"
          git push origin main
        working-directory: ${{ github.workspace }}

      - name: Run sendTestToSlack.py
        run: python sendTestToSlack.py







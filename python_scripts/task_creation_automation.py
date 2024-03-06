import time
import logging
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains
import pyautogui as pya
import pyperclip
from datetime import datetime, timedelta
import sys
import random
import os


logging.basicConfig(filename='timetracker.log', level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')


def copy_clipboard():
    time.sleep(0.3)
    pya.hotkey('ctrl', 'c')

def copy_all_clipboard():
    time.sleep(0.3)
    pya.hotkey('ctrl', 'a')
    pya.hotkey('ctrl', 'c')


def login(driver):
    try:
        driver.find_element_by_name("_username").send_keys("nafiz.hossain@tigerit.com")
        # Get password from environment variable
        password = os.environ.get('TIMETRACKER_PASSWORD')
        print('password', password)

        # Use the password in your code
        driver.find_element_by_name("_password").send_keys(password)
        button = driver.find_element_by_xpath("//button[text()='Login']")
        ActionChains(driver).move_to_element(button).click(button).perform()
    except Exception as e:
        logging.error(f"Error occurred during login: {e}")

def random_sentence():
        rephrased_sentences = {
            "Actively participating in resolving the issue",
            "Presently concentrating on the issue",
            "Dedicated to addressing the issue",
            "Assigned to resolve the issue",
            "Dedicated to solving the problem",
            "Actively troubleshooting the issue",
            "Engaged in finding solutions to the problem",
            "Currently immersed in resolving the issue",
            "Tasked with identifying and resolving the issue",
            "Fully committed to resolving the issue",
            "Focused on addressing the challenge at hand",
            "Actively working towards resolving the issue",
            "Exploring options to tackle the problem",
            "Researching potential solutions for the issue",
            "Implementing strategies to overcome the challenge",
            "Analyzing the root cause of the problem",
            "Collaborating with team members to resolve the issue",
            "Experimenting with different approaches to solve the problem"
        }

        # Combine both sets
        random_sentence = random.choice(list(rephrased_sentences))
        return random_sentence




def append_tasks():
    time.sleep(0.1)

    pya.hotkey('ctrl', 'end')
    time.sleep(0.1)
    pya.hotkey('shift', 'enter')
    time.sleep(0.1)
    # description = "- " + random_sentence() + ": - '" + pyperclip.paste() + "'"

    # description = "- " + random_sentence() + ": - '" + pyperclip.paste() + "'"
    # description = pyperclip.paste()
    # Get text from the clipboard
    text = pyperclip.paste()

    # Split the text into lines
    lines = text.split('\n')

    # Add "- " before every line
    lines_with_dash = ['- ' + line for line in lines]

    # Join the lines back together with newline characters
    modified_text = '\n'.join(lines_with_dash)

    # Copy the modified text back to the clipboard
    description = modified_text    


    pya.typewrite(description)

    time.sleep(0.3)
    copy_all_clipboard()
    paste_text = pyperclip.paste()
    
    time.sleep(0.3)
    pya.hotkey('tab', 'tab', 'tab', 'enter')
    return paste_text


def SortOutTasks(day):
    try:

        if day == "lastday":
            paste_text = pyperclip.paste()
            current_date = datetime.now()
            
            # Calculate the number of days to subtract to get to the previous Thursday

            if current_date.weekday() == 6:  # If today is Sunday
                days_to_subtract = 3  # Subtract 3 days to get to last Thursday (Sunday - 3 days = Thursday)
            else:
                days_to_subtract = 1
            last_thursday = current_date - timedelta(days=days_to_subtract)

            # Format last Thursday's date
            formatted_date = last_thursday.strftime('%d-%b-%Y')
            Lastday = "Last Day (" + formatted_date + ")" + "\n" + "-----------------------------------------------        " + "\n" + paste_text + "\n"
            return Lastday
        elif day == "today":
            today_date = datetime.now().strftime('%d-%b-%Y')

            today = "\n" + "ToDay (" + today_date + ")" + "\n" + "-----------------------------------------------        " + "\n" + todaysTasks + "\n"
            return today
        
    except Exception as e:
        logging.error(f"Error occurred during commchat post creation: {e}")


def fetchLastdayTasks(driver):
    try:
        copy_clipboard()
        # Get the current date
        current_date = datetime.now()

        # current_date.weekday()
            # Monday is 0
            # Tuesday is 1
            # Wednesday is 2
            # Thursday is 3
            # Friday is 4
            # Saturday is 5
            # Sunday is 6

        if current_date.weekday() == 6:  # If today is Sunday
            days_to_subtract = 3  # Subtract 3 days to get to last Thursday (Sunday - 3 days = Thursday)
        else:
            days_to_subtract = 1
        last_thursday = current_date - timedelta(days=days_to_subtract)

        # Format the date as 'YYYY-MM-DD'
        yesterday_date = last_thursday.strftime('%Y-%m-%d')

        # Your existing code continues from here...
        date_elements = WebDriverWait(driver, 5).until(EC.visibility_of_all_elements_located((By.CLASS_NAME, 'text-nowrap')))
        for date_element in date_elements:
            if yesterday_date in date_element.text:
                date_element.click()
                print("Clicked on yesterday's date:", yesterday_date)
                time.sleep(0.2)
                copy_all_clipboard()
                #print("Copied yesterday's task:", pyperclip.paste())
                return
        else:
            print("Yesterday's date not found in the list.")
    except Exception as e:
        logging.error(f"Error occurred during task creation: {e}")





def createTask(driver):
    try:
        # copy_clipboard()
        # Get today's date
        today_date = datetime.now()

        # Format last Thursday's date
        today_formatted = today_date.strftime('%Y-%m-%d')

        # Find the date element corresponding to last Thursday
        date_elements = WebDriverWait(driver, 5).until(EC.visibility_of_all_elements_located((By.CLASS_NAME, 'text-nowrap')))
        for date_element in date_elements:
            if today_formatted in date_element.text:
                date_element.click()
                #print("Clicked on last Thursday's date:", today_formatted)
                time.sleep(0.3)
                temp = append_tasks()
                return temp
        else:
            print("Today's date not found in the list.")



        duration = 8
        customer = "International Consumer"
        project = "CommChat Desktop"
        activity = "Testing"

        driver.get("https://timetracker.tigeritbd.com/index.php/en/timesheet/create")
        WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.ID, 'timesheet_edit_form_duration')))

        actions = ActionChains(driver)
        actions.send_keys(str(duration))





        for _ in range(2):
            actions.send_keys(Keys.TAB)
        actions.send_keys(Keys.ENTER)
        actions.send_keys(customer)
        actions.send_keys(Keys.ENTER)

        actions.send_keys(Keys.TAB)
        actions.send_keys(Keys.ENTER)
        actions.send_keys(project)
        actions.send_keys(Keys.ENTER)

        actions.send_keys(Keys.TAB)
        actions.send_keys(Keys.ENTER)
        actions.send_keys(activity)
        actions.send_keys(Keys.ENTER)

        actions.send_keys(Keys.TAB)
        
        # description = "- " + random_sentence() + ": - '" + pyperclip.paste() + "'"
        description = pyperclip.paste()
        # Get text from the clipboard
        text = pyperclip.paste()

        # Split the text into lines
        lines = text.split('\n')

        # Add "- " before every line
        lines_with_dash = ['- ' + line for line in lines]

        # Join the lines back together with newline characters
        modified_text = '\n'.join(lines_with_dash)

        # Copy the modified text back to the clipboard
        description = modified_text



        actions.send_keys(description)
        time.sleep(0.3)
        copy_all_clipboard()
        paste_text = pyperclip.paste()
        print('##########paste_text', paste_text)

        for _ in range(3):
            actions.send_keys(Keys.TAB)
        actions.send_keys(Keys.ENTER)

        actions.perform()
        return paste_text
    except Exception as e:
        logging.error(f"Error occurred during task creation: {e}")


if __name__ == '__main__':
    try:
        time.sleep(0.3)
        copy_clipboard()

        time.sleep(0.3)
        CHROME_DRIVER_PATH = '/home/nafiz/TigerIT/projects/Automation/Selenium/chromedriver'
        chrome_options = webdriver.ChromeOptions()
        driver = webdriver.Chrome(executable_path=CHROME_DRIVER_PATH, options=chrome_options)
        driver.get("https://timetracker.tigeritbd.com/index.php/en/login")
        WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.ID, 'remember_me')))
        login(driver)
        todaysTasks = createTask(driver)
        #print(todaysTasks)

        print('Creating daily post...')
        fetchLastdayTasks(driver)
        lastday= SortOutTasks("lastday")
        today = SortOutTasks("today")
        final = lastday + today
        pyperclip.copy(final)

        # while True:
        #     time.sleep(1)
    except Exception as e:
        logging.error(f"Main script error: {e}")
    finally:
        if 'driver' in locals():
            driver.close()

# Data manipulation
import pandas as pd # data manipulation and dataframes
import numpy as np # arrays manipulation and mathematical operations

# Web scraping with Selenium
from selenium import webdriver # drives a browser
from webdriver_manager.chrome import ChromeDriverManager # installs and keeps the chrome driver updated
from selenium.webdriver.common.keys import Keys # simulates keyboard keys
from selenium.webdriver.chrome.options import Options # configures the chrome driver as incognito mode or maximizes the window

# Runtime management
from time import sleep # delay between code executions

# Python configuration
import warnings # ignores python warnings
warnings.filterwarnings('ignore')

# HTML parsing
from bs4 import BeautifulSoup

# Regular expresions
import re

# Datetime
from datetime import datetime

# Configuration of the chrome driver
ops = Options()
ops.add_experimental_option('excludeSwitches', ['enable-automation'])

# Hides you as a robot
ops.add_experimental_option('useAutomationExtension', False)
ops.add_argument('--start-maximized') # start maximized
ops.add_argument('user.data-dir=selenium') # saves cookies
ops.add_argument('--incognito') # incognito window

def get_product_urls(supermarket_url):

    urls = [] # products url list
    flag1 = 0 # breaks category loop
    flag2 = 0 # breaks subcategory loop
    total_categories = 100 # exceeds real value # wip
    total_subcategories = 100 # exceeds real value # wip

    # Opens driver
    driver = webdriver.Chrome()

    # Get supermarket url
    driver.get(supermarket_url)
    sleep(3) # waits for cookies pop-up to load

    # Accepts cookies
    driver.find_element('css selector', '#onetrust-accept-btn-handler').click()
    sleep(2)

    # Clicks on products menu
    driver.find_element('css selector', '#app > div > div > div > div.home-view__header > div.dia-header > div.dia-header__section.dia-header__section--start > div > div > button').click()
    sleep(2)

    # Loop to get all subcategory urls inside each category
    for category in range(1, total_categories):

        while 1:

            try:
                
                # Cliks category
                driver.find_element('xpath', f'//*[@id="app"]/div/div/div/div[1]/div[1]/div[1]/div/div[2]/div/div/div[2]/ul/li[{category}]/a').click()
                flag2 = 0 # resets flag2 after each category iteration

                for subcategory in range (1, total_subcategories):

                    while 1:

                        try:
                            
                            # Appends subcategory url to urls list
                            urls.append(driver.find_element("xpath", f'//*[@id="app"]/div/div/div/div[1]/div[1]/div[1]/div/div[2]/div/div/div[2]/ul/li[{category}]/ul/div[{subcategory}]/a').get_attribute("href"))
                            sleep(0.1) # delay between subcategories
                            break

                        except:

                            flag2 = 1 # if the append action fails, flag2 is raised and it breaks
                            break
                        
                    if flag2:
                        
                        break
                
                sleep(1) # delay between categories
                break
            
            except:

                flag1 = 1 # if the click action fails, flag1 is raised and it breaks
                break

        if flag1:

            break

    driver.quit() # closes driver when finish

    return urls

def scrap_products(scraping_result, urls):

    total = 0 # total products count
    page_buttons = [] # page buttons inside subcategories

    # Opens driver
    driver = webdriver.Chrome()

    # For each previously extracted subcategory url
    for u in urls:

            # Get subcategory url
            driver.get(u)
            sleep(3) # waits for cookies pop-up to load

            # Accepts cookies
            try:

                    driver.find_element('css selector', '#onetrust-accept-btn-handler').click()
                    sleep(1)

            except:

                    pass

            # Scrolls down
            Y = 1200 # by pixel
            driver.execute_script(f'window.scrollTo(0, {Y})') 
            sleep(1)

            # Soup creation by parsing html information
            soup = BeautifulSoup(driver.page_source, 'html.parser')

            # Aux lists with parsing info
            cat = soup.find("span", {"class": "plp-breadcrumb__first-level-category"}) # category
            sub = soup.find("span", {"class": "plp-breadcrumb__second-level-category"}) # subcategory
            pro = soup.find_all("p", {"class": "search-product-card__product-name"}) # products
            pri = soup.find_all("p", {"class": "search-product-card__active-price"}) # prices
            kg = soup.find_all("p", {"class": "search-product-card__price-per-unit"}) # price per unit

            # Number of products in the current category
            try:

                    num = soup.find('span', {"class": "plp-breadcrumb__total-items"}).text

            except:

                    num = 0

            # Regex to obtain the numeric value and increment total variable
            total += int(re.findall('\d+', str(num))[0])

            # Cleans and appends scraped results to the dictionary
            for p in pro:
                    scraping_result['supermarket'].append('dia-es') # wip
                    scraping_result['category'].append(cat.text.lower().replace('á', 'a').replace('é', 'e').replace('í', 'i').replace('ó', 'o').replace('ú', 'u').replace('ñ', 'n').replace(',', '').replace(" ", "_"))
                    scraping_result['subcategory'].append(sub.text.lower().replace('á', 'a').replace('é', 'e').replace('í', 'i').replace('ó', 'o').replace('ú', 'u').replace('ñ', 'n').replace(',', '').replace(" ", "_"))
                    scraping_result['name'].append(p.text)
                    scraping_result['insert_date'].append(datetime.today().strftime('%Y-%m-%d'))
                            
            for i in pri:
                    scraping_result['price'].append(i.text.rstrip('\xa0€').replace(',', '.'))
            
            for k in kg:
                    lst = k.text.split('\xa0€/')
                    scraping_result['reference_price'].append(lst[0].lstrip(' (').replace(',', '.'))
                    scraping_result['reference_unit'].append(lst[1].rstrip(') ').lower())
            
            # Finds buttons if exist
            if bool(soup.find_all('a', {'class': 'pagination-button__page--links'})):

                    page_buttons = soup.find_all('a', {'class': 'pagination-button__page--links'})

            else:
                    pass
            
            # Repeats all the process if buttons
            if page_buttons:

                    # For each button (button 1 is already clicked)
                    for button in range(2, int(page_buttons[-1].text)+1):

                            # Clicks button
                            try:

                                    driver.find_element('xpath', f'//*[@id="app"]/div/div/div/div[2]/div[2]/div[3]/div[2]/div/div/div/div[{button}]/a').click()
                                    sleep(1)
                            
                            except:
                                    
                                    # If there are more than 5 buttons
                                    # Clicks right arrow
                                    try:

                                            driver.find_element('xpath', f'//*[@id="app"]/div/div/div/div[2]/div[2]/div[3]/div[2]/div[1]/a[2]').click()
                                            sleep(1)

                                    except:

                                            pass

                                    pass
                            
                            # Same process as before
                            driver.execute_script(f"window.scrollTo(0, {Y})") 
                            sleep(1)

                            soup = BeautifulSoup(driver.page_source, 'html.parser')

                            prod = soup.find_all("p", {"class": "search-product-card__product-name"})
                            precio = soup.find_all("p", {"class": "search-product-card__active-price"})
                            kilo = soup.find_all("p", {"class": "search-product-card__price-per-unit"})
                            
                            for p in prod:
                                    scraping_result['supermarket'].append('dia-es')
                                    scraping_result['category'].append(cat.text.lower().replace('á', 'a').replace('é', 'e').replace('í', 'i').replace('ó', 'o').replace('ú', 'u').replace('ñ', 'n').replace(',', '').replace(" ", "_"))
                                    scraping_result['subcategory'].append(sub.text.lower().replace('á', 'a').replace('é', 'e').replace('í', 'i').replace('ó', 'o').replace('ú', 'u').replace('ñ', 'n').replace(',', '').replace(" ", "_"))
                                    scraping_result['name'].append(p.text)
                                    scraping_result['insert_date'].append(datetime.today().strftime('%Y-%m-%d'))

                            for o in precio:
                                    scraping_result['price'].append(o.text.rstrip('\xa0€').replace(',', '.'))
                            
                            for k in kg:
                                    lst = k.text.split('\xa0€/')
                                    scraping_result['reference_price'].append(lst[0].lstrip(' (').replace(',', '.'))
                                    scraping_result['reference_unit'].append(lst[1].rstrip(') ').lower())
                            
            page_buttons = [] # resets buttons

    driver.quit() # closes driver

    return scraping_result, total
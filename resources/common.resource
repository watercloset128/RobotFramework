*** Settings ***
Documentation       This is the common functions to use across the test suites
...                 and test cases

Library             SeleniumLibrary
Variables           ../resources/variables/locatorvariables.py


*** Variables ***
${BROWSEROPTIONS}           add_argument('--disable-popup-blocking');
...                         add_argument('--ignore-certificate-errors');
...                         add_argument('--guest');
...                         add_argument('--disable-features=Translate');
...                         add_argument('--incognito');
...                         add_argument('--headless');
${URL}                      https://www.advantageonlineshopping.com/#/
${SELENIUMIMPLICITWAIT}     3 seconds
${SELENIUMSPEED}            0.5 seconds


*** Keywords ***
Selenium Initialization
    [Documentation]    Selenium WebDriver Initialization and Configuration Keyword
    Set Selenium Implicit Wait    ${SELENIUMIMPLICITWAIT}
    Set Selenium Speed    ${SELENIUMSPEED}
    Open Browser    ${URL}    Edge    options=${BROWSEROPTIONS}
    Maximize Browser Window

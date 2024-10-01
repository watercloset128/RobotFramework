*** Settings ***
Library         SeleniumLibrary
Library         resources/util/UtilLibrary.py
Variables       resources/variables/locatorvariables.py
Resource        resources/users/userprofile.resource


*** Variables ***
${Options}      add_argument('--disable-popup-blocking'); add_argument('--ignore-certificate-errors'); add_argument('--guest'); add_argument('--disable-features=Translate'); add_argument('--incognito');


*** Test Cases ***
TC_Init
    Log To Console    message='TC Init Started'
    Open Browser    https://www.python.org    Edge    options=${Options}
    Sleep    3 seconds
    Close All Browsers

Quick Test Validation
    Log To Console    ${Laptop_Img}
    ${locatortuple}=    Convert Elementlocator To Tuple String    ${Laptop_Img}
    Log To Console    ${locatortuple}

# Template Test
#     [Template]    User Login
#     Terry    Terry@123
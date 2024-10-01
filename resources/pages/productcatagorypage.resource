*** Settings ***
Documentation       The resource file contains all the steps corresponding to
...                 the shopping catagory page

Library             SeleniumLibrary


*** Keywords ***
Pick up a Product to View
    [Arguments]    ${productlocator}
    Click Image    ${productlocator}

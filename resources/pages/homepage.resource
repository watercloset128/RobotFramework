*** Settings ***
Documentation       The resource file contains all the steps on the home page

Library             SeleniumLibrary
Library             ../../resources/util/UtilLibrary.py


*** Keywords ***
Pick up a Catagory to View
    [Arguments]    ${catagorylocator}
    ${elementexists}=    Convert Elementlocator To Tuple String   ${catagorylocator}
    ${elementexists}=    Evaluate    ${elementexists}
    Wait For Expected Condition    Element To Be Clickable
    ...    ${elementexists}    timeout=10
    Click Element    ${catagorylocator}

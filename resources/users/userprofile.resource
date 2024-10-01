*** Settings ***
Documentation       The Resource file contains all the user cases related to
...                 users profile

Library             SeleniumLibrary
Library             ../../resources/util/UtilLibrary.py
Variables           ../../resources/variables/locatorvariables.py


*** Keywords ***
User Login
    [Arguments]    ${username}    ${password}
    ${elementexists}=    Convert Elementlocator To Tuple String   ${User_btn}
    ${elementexists}=    Evaluate    ${elementexists}
    Wait For Expected Condition    Element To Be Clickable
    ...    ${elementexists}    timeout=10
    Click Element    ${User_btn}
    Input Text    ${Username_txtfield}    ${username}
    Input Password    ${Password_txtfield}    ${password}
    Click Button    ${Sign_in_btn}

Quick Login
    [Arguments]    ${username}    ${password}
    Input Text    ${Quicklogin_Username_txtfield}    ${username}    clear=True
    Input Password    ${Quicklogin_Password_txtfield}    ${password}    clear=True
    Click Button    ${QuickLogin_Login_btn}

User Registratrion
    [Arguments]    ${username}    ${password}    ${emailaddress}
    Input Text    ${Registration_Username}    ${username}
    Input Text    ${Registration_Email}    ${emailaddress}
    Input Password    ${Registration_Password}    ${password}
    Input Password    ${Registration_Confirm_Password}    ${password}
    Scroll Element Into View    id: register_btn
    Select Checkbox    ${i_agree_checkbox}
    Click Button    ${Register_btn}
    ${userexists}=    Get Text    ${User_Exists_txt}
    # IF    $userexists == 'User name already exists'
    IF    'exists' in $userexists
        RETURN    ${False}
    ELSE
        RETURN    ${True}
    END

User Logout
    Click Element    ${User_btn}
    Click Element    ${Logout_btn}

Invalid Login and Logout
    [Arguments]    ${username}    ${password}
    User Login    ${username}    ${password}
    Click Element    ${CloseLogin_btn}

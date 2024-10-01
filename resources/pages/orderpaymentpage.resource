*** Settings ***
Documentation       The resource file contains the page corresponding to the order payment

Library             String
Library             SeleniumLibrary
Resource            ../users/userprofile.resource


*** Keywords ***
Put an Order As ${newuser} With ${username} ${password} AND ${emailaddress}
    ${newuser_lowercase}=    Convert To Lower Case    ${newuser}
    IF    $newuser_lowercase == 'newuser'
        Click Button    ${Order_Registration_btn}
        ${bSuccess}=    User Registratrion    ${username}    ${password}    ${emailaddress}
        IF    $bSuccess == ${False}
            Go Back
            Quick Login    ${username}    ${password}
        END
    ELSE
        Quick Login    ${username}    ${password}
    END
    Click Button    NEXT
    Input Text    name: safepay_username    ${username}    clear=True
    Input Password    name: safepay_password    ${password}    clear=True
    Click Button    PAY NOW

Order Shoulbe be Put Successfully with Text ${paymentsuccessfully}
    Element Attribute Value Should Be
    ...    ${Payment_Confirmation_txt}
    ...    innerText
    ...    ${paymentsuccessfully}

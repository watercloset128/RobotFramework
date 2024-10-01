*** Settings ***
Resource            ../resources/users/userprofile.resource
Resource            ../resources/common.resource

Test Setup          Selenium Initialization
Test Teardown       Close All Browsers
Test Template       Invalid Login and Logout


*** Test Cases ***    Username    Password
Invalid Login Non-Exist    abc    abc@123
Invalid Login Empty User    ${EMPTY}    abc@123
Invalid Login Empty Password    abc    ${EMPTY}

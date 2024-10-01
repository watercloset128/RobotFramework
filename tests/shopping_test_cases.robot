*** Settings ***
Documentation       The end to end shopping flow verification with PO model design

Library             SeleniumLibrary
Library             ../resources/util/UtilLibrary.py
Resource            ../resources/common.resource
Resource            ../resources/users/userprofile.resource
Resource            ../resources/pages/homepage.resource
Resource            ../resources/pages/productcatagorypage.resource
Resource            ../resources/pages/productdetailpage.resource
Resource            ../resources/pages/orderpaymentpage.resource

Test Setup          Selenium Initialization
Test Teardown       Close All Browsers


*** Variables ***
${TESTDATAFILE}     data/MainProcessCase.xlsx


*** Test Cases ***
Shopping Dry Run
    [Documentation]    A dry run test case to verify the system under test is available
    [Tags]    dry_run
    ${TESTDATASHEET}=    Set Variable    Login
    Pick up a Catagory to View    ${Laptop_Img}
    Pick up a Product to View    ${HP_Envy_Laptop_Img}
    ${tabledata}=    Get Test Data From Excel    ${TESTDATAFILE}    ${TESTDATASHEET}
    FOR    ${row}    IN    @{tabledata}
        Sleep    2 seconds
        User Login    ${row}[USERNAME]    ${row}[PASSWORD]
        User Logout
    END

Login Validation with Different Usernames and Passwords
    [Documentation]    Test cases dedicated to login with user credential combination
    [Tags]    dry_run
    ${TESTDATASHEET}=    Set Variable    Login
    Sleep    3 seconds
    ${tabledata}=    Get Test Data From Excel    ${TESTDATAFILE}    ${TESTDATASHEET}
    Log Many    ${tabledata}
    FOR    ${row}    IN    @{tabledata}
        # Log    ${row}[USERNAME]
        User Login    ${row}[USERNAME]    ${row}[PASSWORD]
        User Logout
    END

End to End Shopping Workflow as a New User
    [Documentation]    The Workflow including all the steps from browsing to
    ...    adding products to cart and final payment with a new user.
    [Tags]    end_to_end
    ${TESTDATASHEET}=    Set Variable    AccountCreate
    ${tabledata}=    Get Test Data From Excel    ${TESTDATAFILE}    ${TESTDATASHEET}
    FOR    ${row}    IN    @{tabledata}
        Pick up a Catagory to View    ${Laptop_Img}
        Pick up a Product to View    ${HP_Envy_Laptop_Img}
        Set Product Quantity    2
        Add to Cart
        Go Checkout
        Put an Order As newuser With ${row}[USERNAME] ${row}[PASSWORD] AND ${row}[EMAIL]
        Order Shoulbe be Put Successfully with Text Thank you for buying with Advantage
        User Logout
    END

End to End Shopping Workflow as a Return User
    [Documentation]    The Workflow including all the steps from browsing to
    ...    adding products to cart and final payment with a return user.
    [Tags]    end_to_end    smoketest
    ${TESTDATASHEET}=    Set Variable    Login
    ${tabledata}=    Get Test Data From Excel    ${TESTDATAFILE}    ${TESTDATASHEET}
    FOR    ${row}    IN    @{tabledata}
        Pick up a Catagory to View    ${Mice_Img}
        Pick up a Product to View    ${HP_Z3200_Img}
        Set Product Quantity    2
        Add to Cart
        Go Checkout
        Put an Order As Returnuser With ${row}[USERNAME] ${row}[PASSWORD] AND ${None}
        Order Shoulbe be Put Successfully with Text Thank you for buying with Advantage
        User Logout
    END

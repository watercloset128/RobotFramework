*** Settings ***
Documentation       The resource file contains all the steps corresponding to
...                 the product detail page

Library             SeleniumLibrary
Variables           ../../resources/variables/locatorvariables.py


*** Keywords ***
Set Product Quantity
    [Documentation]    The step to modify the quantity to be added to the cart.
    ...    The arguemnts is to set the quantity. Using Keyboard simulation instead of
    ...    Input Text as here comes the shadow dom which cannot be interacted directly.
    [Arguments]    ${quantity}
    # Click Element    //*[@id="productProperties"]/div[2]/e-sec-plus-minus/div/div[3]
    # Click Element    ${Quantity_Plus_btn}
    Click Element    ${Quantity_txtfield}
    Press Key    ${Quantity_txtfield}    ${quantity}

Add to Cart
    [Documentation]    The step to add the product to the cart.
    # Click Button    ADD TO CART
    Click Button    ${Add_To_Cart_btn}

Go Checkout
    # ${cnt}=    Get Element Count    id: checkOutPopUp
    ${cnt}=    Get Element Count    ${Checkout_btn}
    IF    ${cnt} == 0
        # Click Element    id: menuCart
        Click Element    ${Cart_btn}
    END
    Click Button    ${Checkout_btn}

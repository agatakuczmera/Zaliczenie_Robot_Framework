*** Settings ***
Library         SeleniumLibrary
Documentation   This class consist of two test cases.
...             First one is a negative scenario, where user cannot login when invalid credentials are used.
...             Second one is a positive scenario, where user can add a product to the shopping cart.

*** Variables ***
${TAB}             \\9
${SLEEP}           3
${LOGIN URL}       https://www.bmw.pl/pl/shop/ls/cp/connected-drive
${LOGIN_BUTTON_1}  //*[@id="__next"]/div[2]/div[7]/div/div/div[3]/div/div/div/a[2]/button
${LOGIN_BUTTON_2}  //*[@id="login-form"]/div[3]/div[2]/button
${LOGIN_INPUT}     //*[@id="email"]
${PASS_INPUT}      //*[@id="password"]
${SHOPPING_CART}   //*[@id="__next"]/div[2]/div[1]/div/div/div/div[2]/div/a[1]
${PRODUCT}         //*[@id="__next"]/div[2]/div[8]/div[2]/div[4]/div[3]/button[1]
${PRODUCT_DELETE}  //*[@id="__next"]/div[2]/div[7]/div[2]/div[1]/div[1]/div/div[3]/div[4]
${INVALID_LOGIN}   test@gmail.com
${INVALID_PASS}    testPassword
${DELETE_LABEL}    Usuń


*** Keywords ***
Open Browser To Given URL
    Open Browser  ${LOGIN URL}      chrome

*** Test Cases ***
Denied Login with Wrong Credentials
    [Tags]    negative
    Open Browser To Given URL
    Click Element           ${LOGIN_BUTTON_1}
    Sleep                   ${SLEEP}
    Set Focus To Element    ${LOGIN_INPUT}
    Input Text              ${LOGIN_INPUT}     ${INVALID_LOGIN}
    Set Focus To Element    ${PASS_INPUT}
    Input Text              ${PASS_INPUT}     ${INVALID_PASS}
    Sleep                   ${SLEEP}
    Press Key               ${LOGIN_BUTTON_2}    ${TAB}
    Click Element           ${LOGIN_BUTTON_2}
    Sleep                   ${SLEEP}
    Capture Page Screenshot
    Close Browser

Product added to the BMW shopping cart
    [Tags]    positive
    Open Browser To Given URL
    Click Element               ${PRODUCT}
    Sleep                       ${SLEEP}
    Click Element               ${SHOPPING_CART}
    Sleep                       ${SLEEP}
    Wait Until Element Contains     ${PRODUCT_DELETE}  ${DELETE_LABEL}
    Capture Page Screenshot
    Close Browser
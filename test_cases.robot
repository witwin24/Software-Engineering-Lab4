*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CHROME_BROWSER}    D:/ChromeForTesting${/}chrome.exe
${CHROME_DRIVER}     D:/ChromeForTesting${/}chromedriver.exe
${URL}               http://localhost:7272/Lab4/Registration.html

${FIRST_NAME}    Somyod
${LAST_NAME}     Sodsai
${ORGANIZATION}  CS KKU
${EMAIL}         somyod@kkumail.com
${PHONE}         091-001-1234

*** Test Cases ***
Open Workshop Registration Page:
    Open Chrome

Register Success:
    Open Chrome

    Full Name
    Organization Info
    Contact Info
    Click Element  id=registerButton

    Title Should Be  Success
    Page Should Contain    Thank you for registering with us.
    Page Should Contain    We will send a confirmation to your email soon.

Register Success No Organization Info:
    Open Chrome
    
    Full Name
    Contact Info
    Click Element  id=registerButton

    Title Should Be  Success
    Page Should Contain    Thank you for registering with us.
    Page Should Contain    We will send a confirmation to your email soon.

Empty First Name:
    Open Chrome
    Input Text    id=lastname       ${LAST_NAME}
    Organization Info
    Contact Info
    Click Element  id=registerButton

    Title Should Be  Registration
    Page Should Contain    Please enter your first name!!

Empty Last Name:
    Open Chrome

    Input Text    id=firstname      ${FIRST_NAME}
    Organization Info
    Contact Info
    Click Element  id=registerButton

    Title Should Be  Registration
    Page Should Contain    Please enter your last name!!

Empty First Name and Last Name:
    Open Chrome

    Organization Info
    Contact Info
    Click Element  id=registerButton

    Title Should Be  Registration
    Page Should Contain    Please enter your name!!

Empty Email:
    Open Chrome

    Full Name
    Organization Info
    Input Text    id=phone          ${PHONE}
    Click Element  id=registerButton

    Title Should Be  Registration
    Page Should Contain    Please enter your email!!

Empty Phone Number:
    Open Chrome

    Full Name
    Organization Info
    Input Text    id=email          ${EMAIL}
    Click Element  id=registerButton

    Title Should Be  Registration
    Page Should Contain    Please enter your phone number!!

Invalid Phone Number:
    Open Chrome

    Full Name
    Organization Info
    Input Text    id=email          ${EMAIL}
    Input Text    id=phone          1234
    Click Element  id=registerButton

    Title Should Be  Registration
    Page Should Contain    Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678)
    
*** Keywords ***
Open Chrome
    ${opts}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${svc}=     Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER}")
    Create Webdriver    Chrome    options=${opts}    service=${svc}
    Set Selenium Speed  0
    Go To    ${URL}

Full Name
    Input Text    id=firstname      ${FIRST_NAME}
    Input Text    id=lastname       ${LAST_NAME}

Contact Info
    Input Text    id=email          ${EMAIL}
    Input Text    id=phone          ${PHONE}
    
Organization Info
    Input Text    id=organization   ${ORGANIZATION}
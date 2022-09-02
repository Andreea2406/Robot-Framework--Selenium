*** Settings ***
Library  SeleniumLibrary
Library  ExcelOperations.py
Library   Collections
*** Variables ***
${Browser}  Chrome
${url}  https://www.google.com/webhp?hl=ro&sa=X&ved=0ahUKEwjC0tSt9bn3AhXuMewKHYsQD4MQPAgI

*** Keywords ***
writeLinks
    [Arguments]   ${title}  ${link}  ${id}  ${doi}  ${date}   ${citation}
    ${s2}=  Writelink   ${title}  ${link}  ${id}  ${doi}  ${date}   ${citation}
    [Return]    ${s2}

closing
    ${close}=  Closing
*** Test Cases ***
webOperations
    Open Browser   ${url}    chrome
    Maximize browser window
#    set selenium speed  1 seconds
    execute javascript  window.scrollTo(0,1000000000)
    mouse over   xpath://button[@id="L2AGLb"]
    Click Button  xpath://button[@id="L2AGLb"]  ENTER
    Press Keys  name:q  pubmed
    Press keys  None   ENTER
    mouse down on link   xpath=//a[@href="https://pubmed.ncbi.nlm.nih.gov/"]
    Click Link       xpath=//a[@href="https://pubmed.ncbi.nlm.nih.gov/"]
    Press Keys    name:term   Leo
    Press Keys    None   SPACE
    Press Keys    name:term   CH
    mouse over   xpath://button[@type="submit"]
    Click Button  xpath://button[@type="submit"]


    ${nrpag}  Get Element Attribute   class:page-number  max
    Log To Console  ${nrpag}
    FOR  ${j}  IN RANGE   1   (${nrpag})
        ${links_nr}=  get element count  xpath://a[@class="docsum-title"]
        @{links}  Create List
        Log to Console  ${j}
        FOR  ${i}  IN RANGE  1   ${links_nr}+1
            ${link}=    Get Element Attribute    xpath=(//a)[${i}]  href
            Click Element   xpath=(//a[@class="docsum-title"])[${i}]
            ${title}=  Get Text   xpath=//h1[@class="heading-title"]
            ${id}=    Get Text    xpath=//strong[@class="current-id"]
            ${doi}=    Get Element Attribute    xpath:(//a[@class="id-link"])  href
            ${date}=    Get Text    xpath=//span[@class="cit"]
            Go back
            ${citation}=  Get Text  xpath:(//label)[@class="search-result-position"][${i}]
            ${function_call}=  writeLinks  ${title}  ${link}   ${id}  ${doi}  ${date}   ${citation}
        END
        Click Button   xpath://button[@class="button-wrapper next-page-btn"]
    END


    ${links_nr}=  get element count  xpath://a[@class="docsum-title"]
    FOR  ${i}  IN RANGE  1   ${links_nr}+1
            ${link}=    Get Element Attribute    xpath=(//a)[${i}]  href
            Click Element   xpath=(//a[@class="docsum-title"])[${i}]
            ${title}=  Get Text   xpath=//h1[@class="heading-title"]
            ${id}=    Get Text    xpath=//strong[@class="current-id"]
            ${doi}=    Get Element Attribute    xpath:(//a[@class="id-link"])  href
            ${date}=    Get Text    xpath=//span[@class="cit"]
            Go back
            ${citation}=  Get Text  xpath:(//label)[@class="search-result-position"][${i}]
            ${function_call}=  writeLinks  ${title}  ${link}   ${id}  ${doi}  ${date}  ${citation}
    END

    ${Excel_closing}=  closing
    Close Browser

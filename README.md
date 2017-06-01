## XML prezentácia

Za pomoci jazyka XML som vytvoril prezentáciu reprezentujúcu niekoľko typov slajdov. Štruktúru XML prezentácie som vytvoril prostredníctvom jazyka RELAX NG. Následne som vytvoril XSL súbor, ktorý tvorý šablónu pre transformáciu XML prezentácie do formátu XHTML. K XSL súboru som pripojil CSS súbor reprezentujúci štýl výstupného XHTML súboru. Súčasťou riešenia je aj XSL súbor pre transformáciu XML prezentácie do formátu PDF.

---

#### Štruktúra XML prezentácie
* koreňovým elementom je element ```presentation```, ktorý obsahuje minimálne jeden element ```slide```
* atribút ```type``` elementu ```slide``` určuje typ konkrétneho slajdu
* každý element ```slide``` musí obsahovať element ```title``` reprezentujúci nadpis daného slajdu
* o tom, čo je ďalším obsahom elementu ```slide``` rozhoduje už spomínaný atribút ```type```
* medzi základné elementy, ktoré môže ```slide```obsahovať sú ```list``` resp. trojúrovňový zoznam, ```image``` resp. obrázok, ```table``` resp. tabuľku alebo ```resource``` resp. zdroj
* jednotlivé typy slajdov obsahujú kombinácie základných elementov
* ```title-slide``` obsahuje okrem ```title``` iba autora
* ```content``` nemá žiadny obsah, pretože sa generuje automaticky
* ```list-only``` obsahuje trojúrovňový zoznam
* ```list-image``` obsahuje obrázok a trojúrovňový zoznam
* ```comparison``` obsahuje dva trojúrovňové zoznamy
* ```table-only``` obsahuje tabuľku s popisom
* ```image-only``` obsahuje obrázok s popisom
* ```resources``` obsahuje použité zdroje prezentácie
* XML prezentácia je uložená v súbore **presentation.xml**
* je valídna podľa schémy vytvorenej v jazyku RELAX NG uloženej v súbore **relax_ng.rng**
* validácia XML prezentácie bola testovaná v nástroji XMLBlueprint **Jing** procesorom

---

#### XSL pre transformáciu do XHTML
* uložený v súbore **transformation.xsl**
* je založený na princípe templatov podľa potreby pre každý typ slajdu a iné potrebné elementy
- v úvodnej časti sú prostredníctvom DTD definované tri súbory
  * ```style.css``` - CSS súbor reprezentujúci štýl výstupného XHTML súboru
  * ```nested_list.xsl``` - implementácia trojúrovňového zoznamu, ktorý som sa rozhodol definovať takto, pretože sa využíva vo viacerých častiach XSL súboru a mohlo by teda dôjsť k redudancii kódu
  * ```image.xsl``` - implementácia zobrazovania obrázkov, definovaný opäť z dôvodu, že sa používa vo viacerých častiach XSL súboru
- ```<xsl:template match="slide" priority="2">``` je template, ktorý obsahuje        
  * základnú html štruktúru výstupného XHTML súboru
  * funkciu ```result-document```, ktorá generuje každý slajd prezentácie do samostatného XHTML súboru
  * implementáciu pridávania čísel slajdov
* ďalej nasledujú templaty pre písma ```italic```, ```bold``` a ```underline```
* obsahom zvyšku XSL súboru sú templaty pre konkrétny typ slajdu
* každý z týchto templatov obsahuje potrebnú implementáciu transformácie do výslednej podoby podľa konkrétneho obsahu slajdu
* súbor automaticky generuje obsah s reálnymi klikateľnými odkazmi na jednotlivé slajdy resp. XHTML súbory
* tranformácia do formátu XHTML vykonával **SAXON**
- používateľ má možnosť zadať dva špeciálne parametre pri spúšťaní transformácie
  * ```page-number``` - umožňuje vypnúť generovanie čísel slajdov (defaultne generuje čísla)
  * ```font-type``` - umožňuje nastaviť vlastné písmo prezentácie (defaultne Thimes New Roman)

---

#### XSL pre transformáciu do PDF
* uložený v súbore **mytrans.xsl**
* založený na rovnakom princípe ako XSL pre transformáciu do XHTML
- v úvodnej časti sú prostredníctvom DTD definované dva súbory
  * ```nested_list_fo.xsl``` - implementácia trojúrovňového zoznamu, ktorý som sa
  rozhodol definovať takto, pretože sa využíva vo viacerých častiach XSL súboru a mohlo by teda dôjsť k redudancii kódu
  * ```image_fo.xsl``` - implementácia zobrazovania obrázkov, definovaný opäť z dôvodu, že sa používa vo viacerých častiach XSL súboru
* ```<xsl:template match="/">``` obsahuje základnú štruktúru pdf dokumentu, veľkosti slajdov, generovanie čísel slajdov ...
* súbor automaticky generuje obsah s reálnymi klikateľnými odkazmi na jednotlivé slajdy
* nasledujú rovnaké templaty ako pri predošlom XSL súbore
* namiesto html tagov a css štýlu sú využívané ```fo``` objekty a ich vlastnosti
* transformáciu do formátu PDF zabezpečuje **pdf_xep_mytrans.bat** bat súbor, rovnaký ako pri generovaní dokumentu v Docbooku

---

import 'package:Fit24/helper/text_style_helper.dart';
import 'package:Fit24/model/info_arguments.dart';
import 'package:Fit24/ui_scaler/ui_scaler.dart';
import 'package:flutter/material.dart';

class ExtraInfoScreen extends StatelessWidget {
  static const String routName = '/ExtraInfoScreen';

  var listTitle = ['Body Mass Index',
    'Basal Metabolic Rate',
  'END USER LICENCE AGREEMENT','Privacy Policy'];
  var listBody = [
    'What’s Body Mass Index?\n\nYour BMI tells you what your body is made of, or how much fat it has in its composition. It does not exactly measure the amount of fat in your body, but analyzing your height and weight helps determine if you are obese, overweight, underweight or if your weight is normal.\nAccording to the Centers for Disease Control and Prevention, the BMI measurement is reasonably close to other methods of determining a person’s weight status, like underwater weighing or skinfold measuring.\n\nTo get your BMI, you need to divide your weight (in lbs) by the square of your height (in inches) and multiply the result by 703. For example, if you weigh 160 lbs and are 68 inches tall (5’8”). You will calculate your BMI like this: (160:(68x68))x703= 24.33\n  Now check where your BMI places you on the scale:\nYour BMI                          You are\nBelow 18.5                       Underweight\n18.5 to 24.9                      Normal weight\n25 to 29.9                         Overweight\n30 and above                   Obese\n\nBMI Limitations\nSince determining a person’s BMI does not require any physical measurements to be taken, it may not be used as a diagnostic tool. For instance, average or low-height people with a lot of muscle (such as bodybuilders) may get classified as overweight, while in reality their weight may be quite healthy. This happens because muscle mass is denser and therefore heavier, but BMI has no way of taking that into consideration.',
    'What is Basal Metabolic Rate?\nBasal Metabolic Rate (BMR) is calculated based on the amount of energy your body is consuming while at rest, performing physiological tasks like pumping blood, breathing or digesting meals. The number of calories a person needs in an idle state depends on one’s genetics, gender, everyday activity level, and body composition, among other factors. Body mass index (BMI) indirectly influences the BMR as well. For example, those with a significant muscle mass tend to burn more calories at rest as muscle is more metabolically active. However, the BMR and BMI relationship is not linear. Another example would be an overweight person who is also physically active with a high BMR.\n\nBMR for females can be calculated by applying the Harris-Benedict formula: 655 + (4.35 x weight in pounds) + (4.7 x height in inches) – (4.7 x age in years). And the equation for males is calculated as follows: 66 + (6.23 x weight in pounds) + (12.7 x height in inches) – (6.8 x age in years).\nAlthough BMI and BMR can help your doctor or nutritionist assess what your body is made up with or how you burn calories, they still don’t give a full-proof guideline that would fit all. We are all different, so it’s always a good idea to consult a professional before starting a workout program.',
    '\n\nTO CONTINUE WITH THE INSTALLATION, YOU MUST ACCEPT THE TERMS OF THE SOFTWARE LICENCE AGREEMENT BELOW.\nPLEASE READ THIS SOFTWARE LICENCE AGREEMENT CAREFULLY. PERMISSION TO USE THIS SOFTWARE IS CONDITIONAL ON YOU AGREEING TO THE TERMS OF THIS LICENCE. IF YOU USE THIS SOFTWARE, YOU ARE AGREEING TO THE TERMS OF THIS LICENCE.\n\nTO ACCEPT THESE TERMS, CLICK ‘START’. ACCEPTANCE SHALL BIND YOU AND (IF APPLICABLE) YOUR EMPLOYEES TO THE TERMS OF THIS LICENCE.\n\nBY CLICKING ‘START’ YOU AGREE THAT YOU HAVE READ ALL OF THE TERMS OF THIS AGREEMENT.\n\nIF YOU DO NOT WISH TO ACCEPT THESE TERMS, DO NOT INSTALL THE SOFTWARE.\n\nBACKGROUND TO THE LICENCE:\n\nA.	A reference in this Licence to the “Software” means the software product identified above and a reference to the “Documentation” includes any documentation provided by Outbyte to use the software.\n\nB.	You wish to use the Software.\n\nC.	Outbyte Computing Pty Ltd (“Outbyte”) grants you a non-transferable non-exclusive licence to use the Software on the terms and conditions of this Licence.\n\nPROVISIONS OF THE LICENCE:\n\nLICENCE\n\nIn consideration of the payment by you of the applicable fee indicated on Outbyte’s web site (unless the software is free of charge which will also be indicated) in respect of the Software (the “Fee”) Outbyte grants to you a non-exclusive and non-transferable licence to:\n\n(a)	install and use the Software and Documentation for your own personal or internal business purposes subject to the terms of this Licence;\n\n(b)	make one copy of the Software and Documentation for backup and disaster recovery purposes only; and\n\n    (c)	use the Software and Documentation strictly in accordance with the provisions of this Licence and any documentation provided by Outbyte for that purpose.\n\nOutbyte reserves all rights not expressly granted to you in this Licence.\n\nThe Software licenced to you may be used by a single person personally on one or more computers. Only you can use this copy of the software. In order for someone else to use a copy of this software they must obtain their own individual and separate license.\n\n1.3	You undertake:\n\n(a)	to supervise and control the use of the Software in accordance with the terms of this Licence;\n\n(b) 	to ensure that (if applicable) your employees, sub-contractors and other agents who have authorised access to the Software are made aware of the terms of, and comply with, this Licence;\n\n(c) 	to not provide or otherwise make available the Software in any form to any person other than as permitted in this Licence; and\n\n    (d) 	to ensure that any permitted copy of the Software and Documentation bears notice of Outbyte’s ownership of copyright.\n\nLICENCE FEES\n\nThe Licence and Fee (if any) are exclusive of taxes, duties and charges imposed or levied in Australia in connection with the supply and installation of the Software. Without limiting the foregoing, you shall be liable for any subsequent taxes, duties or charges in respect of the Software.\n\nGOODS AND SERVICES TAX\n\n\nAll amounts payable or other consideration provided in respect of supplies made in relation to this Licence are exclusive of GST (if any).  Where a supply is a taxable supply, all amounts payable or other consideration provided must be increased by the amount of GST payable in relation to the supply.\n\nAll GST must be paid at the time any payment to which it relates is payable (provided a tax invoice has been issued for the supply).  Where any GST payable is not referable to an actual payment, then it must be paid within ten (10) days of a tax invoice being issued by the party making the supply.\n\nMODIFICATIONS\n\nYou must not modify or alter the Software or merge all or any part of the Software with any other software without Outbyte’s written permission.  If the Software is modified or altered:\n\nthe costs associated with the modifications or alterations will be borne solely by you; and\n\nyou will fully indemnify Outbyte against all liability, cost and expenses (including legal costs) which may be incurred by Outbyte if such modifications or alterations infringe any intellectual property rights of a third person or otherwise cause Outbyte to suffer loss, damages or expense.\n\nThe Software as modified or altered remains the property of Outbyte in all respects, whether modified by you, Outbyte or a third party and whether or not authorised pursuant to this Licence. You must assign to Outbyte all intellectual property rights arising out of any modifications to the Software.\n\nThis Licence applies to the Software as modified or altered.\n\nOther than as required by law. you may not reverse engineer, reverse assemble or reverse compile or directly or indirectly allow or cause a third party to reverse engineer, reverse assemble or reverse compile the whole or any party of the Software.\n\nSECURITY\n\nYou are responsible for the use, supervision, management and control of the Software and Documentation.\n\nYou must use reasonable endeavours to ensure that the Software is protected at all times from misuse, damage, destruction or any form of unauthorised use.\n\nYou must keep accurate records of use, copying, modification and disclosure of the Software.\n\nUPDATES AND NEW RELEASES\n\nOutbyte may in its sole discretion notify you from time to time of any update or new release of the Software which provides functions equal to or better than the Software.\n\nWhere an update or new release is provided by Outbyte:\n\nyou must immediately install the update or new release and Outbyte is not liable for, and will (notwithstanding any other provision of this Licence) not accept any liability for any previous version or release; and\n\nyou may be required to enter into a new licence for the new update or release and this Licence (and any previous licence for the Software) will be terminated immediately upon your acceptance of those terms.  In the event that no new licence is supplied, this Licence will continue to apply in all respects to the update or new release which shall be deemed to be the Software for the purpose of this Licence.\n\nWARRANTIES\n\nOutbyte warrants that:\n\nit has authority to grant the rights granted in this Licence; and\n\nthe Software will operate in conformity with the Documentation in all material respects.\n\nOUTBYTE WILL NOT BE LIABLE UNDER THIS CLAUSE TO THE EXTENT THAT A DEFECT IS CAUSED BY YOUR USE OF THE SOFTWARE OTHER THAN IN ACCORDANCE WITH THIS LICENCE, INCLUDING THE FAILURE BY YOU OR A THIRD PARTY TO MAINTAIN THE OPERATING ENVIRONMENT DESIGNATED IN THE DOCUMENTATION OR TO OTHERWISE USE THE SOFTWARE IN ACCORDANCE WITH ANY SPECIFICATIONS ISSUED BY OUTBYTE.\n\n\nANY INFORMATION PROVIDED IN THE SOFTWARE OR ON OUTBYTE’S WEBSITES DOES NOT CONSTITUTE MEDICAL OR PROFESSIONAL ADVICE AND SHOULD NOT BE TREATED AS SUCH. YOUR USE OF THE FIT24 APP BY OUTBYTE IS SOLELY AT YOUR OWN RISK. YOU ARE STRONGLY ADVISED TO CONSULT A MEDICAL PROFESSIONAL BEFORE USING THE FIT24 APP OR STARTING AN EXERCISE PROGRAM. ANY HEALTH-RELATED INFORMATION IN THE SOFTWARE OR ON OUTBYTE’S WEBSITES IS PROVIDED WITHOUT ANY REPRESENTATIONS OR WARRANTIES, EXPRESS OR IMPLIED. YOU TAKE FULL RESPONSIBILITY FOR ANY CONSEQUENCES THAT MAY ARISE OUT OF YOUR USE OF THE FIT24 APP OR WEBSITE.\n\nYOU ACKNOWLEDGE THAT THE SOFTWARE IS DISTRIBUTED AS IS AND OUTBYTE IN NO WAY GUARANTEES THAT IT WILL OPERATE UNINTERRUPTED OR BE ERROR FREE.  YOU ACKNOWLEDGE THAT THE EXISTENCE OF ANY ERRORS DOES NOT CONSTITUTE A BREACH OF THIS LICENCE.\n\nYOU FURTHER ACKNOWLEDGE THAT GOOD DATA PROCESSING PROCEDURES DICTATE THAT ANY SOFTWARE BE THOROUGHLY TESTED WITH NON-CRITICAL DATA BEFORE RELYING ON IT. YOU ASSUME THE ENTIRE RISK OF USING THE SOFTWARE AND DOCUMENTATION. THIS DISCLAIMER OF WARRANTY CONSTITUTES AN ESSENTIAL PART OF THIS LICENSE.\n\nYOU ACKNOWLEDGE THAT YOU HAVE EXERCISED YOUR INDEPENDENT JUDGEMENT IN LICENSING THE SOFTWARE AND HAVE NOT RELIED ON ANY REPRESENTATION MADE BY OUTBYTE WHICH HAS NOT BEEN STATED EXPRESSLY IN THIS LICENCE OR UPON ANY DESCRIPTIONS OR ILLUSTRATIONS OR SPECIFICATIONS CONTAINED IN ANY DOCUMENT INCLUDING PUBLICITY MATERIAL PRODUCED BY OUTBYTE.\n\nOTHER THAN IMPLIED BY LAW (INCLUDING BUT NOT LIMITED TO THE AUSTRALIAN CONSUMER LAW), THE WARRANTIES IN THIS CLAUSE REPRESENT ALL OF THE WARRANTIES GIVEN BY OUTBYTE AND NO TERM OR WARRANTY WILL BE IMPLIED.\n\nCONFIDENTIALITY\n\nA party may not, without the prior written approval of the other party, disclose the other party’s Confidential Information (as defined below). A party will not be in breach of this Licence in circumstances where it is legally compelled to disclose the other party’s Confidential Information.\n\nEach party must take all reasonable steps to ensure that its employees and agents, and any sub-contractors engaged for the purposes of this Licence, do not disclose the other party’s Confidential Information.\n\nA party may disclose the other party’s Confidential Information:\n\nto its related companies, solicitors, auditors, insurers and accountants who require information for the purpose of this Licence; or\n\nif required to disclose the information by law or the rules of any Stock Exchange.\n\nThis clause will survive the termination of this Licence.\n\nINTELLECTUAL PROPERTY RIGHTS\n\nYou acknowledge that the Software and Documentation are the subject of intellectual property rights including copyright (the “Rights”). You shall not during or any time after the termination of this Licence permit any act (including without limitation copying the Software except as permitted in this Licence) which infringes those Rights. For the avoidance of doubt this Licence does not give you any right to use any trademarks of Outbyte associated with the Software or Documentation. You will fully indemnify Outbyte against all liability, cost and expenses (including legal costs) which may be incurred by Outbyte as a result of your breach of the provisions of this clause 10.\n\nLIABILITY\n\nSUBJECT TO CLAUSE 10.2, OUTBYTE’S TOTAL LIABILITY TO YOU IN RESPECT OF ALL CLAIMS ARISING OUT OF OR IN ANY WAY RELATING TO THIS LICENCE OR THE SOFTWARE INCLUDING CLAIMS UNDER ANY INDEMNITY OR FOR NEGLIGENCE SHALL BE STRICTLY LIMITED TO THE FEE PAID UNDER THIS LICENCE.\n\nANY DAMAGES RESULTING FROM A BREACH OF THIS LICENCE BY EITHER PARTY IS LIMITED TO ACTUAL DAMAGES INCURRED BY THE PARTY CLAIMING DAMAGES.  NEITHER PARTY WILL BE LIABLE TO THE OTHER FOR ANY SPECIAL, INDIRECT, CONSEQUENTIAL OR INCIDENTAL LOSS OR DAMAGE INCLUDING BUT NOT LIMITED TO LOSS OF BUSINESS OPPORTUNITY, BUSINESS INTERRUPTION, LOST PROFITS OR FOR PUNITIVE OR EXEMPLARY DAMAGES EVEN IF OUTBYTE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.\n\nIF ANY CONDITION OR WARRANTY IS IMPLIED INTO THIS AGREEMENT BY LAW AND CANNOT BE EXCLUDED, THE LIABILITY OF OUTBYTE FOR BREACH OF THE CONDITION OR WARRANTY IS LIMITED TO ONE OR MORE OF THE FOLLOWING AT OUTBYTE’S OPTION:\n\n(I)   IN THE CASE OF GOODS;\nTHE REPLACEMENT OF THE GOODS OR THE SUPPLY OF EQUIVALENT GOODS;\nTHE REPAIR OF THE GOODS;\nTHE PAYMENT OF THE COST OF REPLACING THE GOODS OR OF ACQUIRING EQUIVALENT GOODS; OR\nTHE PAYMENT OF THE COST OF HAVING THE GOODS REPAIRED; OR\n\n\n    (II)   IN THE CASE OF SERVICES;\nTHE SUPPLYING OF THE SERVICES AGAIN; OR\nTHE PAYMENT OF THE COST OF HAVING THE SERVICES SUPPLIED AGAIN.\n\n10.4 		BY ENTERING INTO THIS AGREEMENT, YOU EXPRESSLY WAIVE THE RIGHT TO PARTICIPATE IN A CLASS ACTION AGAINST OUTBYTE AND ANY OF OUTBYTE’S SUBSIDIARIES, RELATED COMPANIES, AFFILIATES, AGENTS, EMPLOYEES, PREDECESSORS IN INTEREST, SUCCESSORS AND ASSIGNS UNDER THIS AGREEMENT OR ANY PRIOR AGREEMENTS BETWEEN US. THIS PROVISION SHALL SURVIVE TERMINATION OF THE END USER LICENCE AGREEMENT.\n\nTERMINATION\n\n11.1	 A party may terminate this Licence immediately by written notice if:\n\nthe other party is in material breach of any term of this Licence and such breach is not remedied within thirty (30) days of notification; or\n\nthe other party becomes, threatens or resolves to become or is in jeopardy of becoming subject to any form of insolvency administration.\n\nUpon termination of this Licence you must immediately cease using the Software and destroy all copies of the Software and the Documentation.\n\nGENERAL\n\nYou may not assign this Licence without the written consent of the other party (such consent not to be unreasonably withheld or delayed).\n\nAny express statement of a right of Outbyte under this Licence is without prejudice to any other rights of Outbyte expressly stated in this Licence or existing at law.\n\nThe obligations of the parties under this Licence are suspended during the continuance of any Force Majeure Event to the extent that those obligations are affected by the Force Majeure Event.\n\nThis Licence is governed by the laws of New South Wales, Australia and the parties submit to the non-exclusive jurisdiction of the courts exercising jurisdiction there.\n\nAll notices must be in writing and addressed in the case of notices to Outbyte to its registered office.\n\n\nEach party must take all steps as may be reasonably required by the other party to give effect to the terms of this Licence and transactions contemplated by this Licence.\n\nThis Licence contains the entire agreement between the parties with respect to its subject matter.\n\nEach party acknowledges that in entering into this Licence it has not relied on any representation or warranties about its subject matter except as provided in this Licence.\n\nNo delay, neglect or forbearance on the part of any party in enforcing against any other party any obligation under this Licence will operate as a waiver or in any way prejudice any right under this Licence.\n\nIf any provision of this Licence is held to be invalid, illegal or unenforceable, this Licence will continue otherwise in full force and effect apart from such provision which will be taken to be deleted.\n\nAny variation of this Licence must be in writing signed by each party.\n\nDEFINITIONS AND INTERPRETATION\n\nDefinitions\n\nIn this Licence, unless the context otherwise requires:\n\n“Confidential Information” means the confidential information of a party which relates to the subject matter of this agreement and includes information relating to:\n\nthe design, specification and content of the Software;\n\nthe personnel, polices or business strategies of Outbyte; and\n\nthe terms upon which the Software is being supplied and installed pursuant to this Licence.\n\n“Force Majeure Event” means any event not within the control of a party whose obligations are affected;\n\n“GST” means goods and services tax or any similar tax;\n\nIn this Licence, unless the context otherwise requires:\n\nheadings are for convenience only and do not affect interpretation;\n\nthe singular includes the plural and conversely;\n\nthe gender includes all genders;\n\nwhere a word or phrase is defined, its other grammatical forms have a corresponding meaning;\n\na reference to a person includes any body corporate, unincorporated body or other entity and conversely;\n\na reference to a clause is to a clause of this Licence;\n\na reference to any party to this Licence or any other agreement or document includes the party’s successors and permitted assigns;\n\na reference to any agreement or document is to that agreement or document as amended, notated, supplemented, varied or replaced from time to time, where applicable, in accordance with this Licence or that other agreement or document;\n\na reference to any legislation or to any provision of any legislation includes any modification or re-enactment of it, any legislative provision substituted for it and all regulations and statutory instruments issued under it;\n\na reference to conduct includes, without limitation, any omissions, statement or undertaking, whether or not in writing;\n\nall references to \$ are to Australian dollars; and\n\nwhere two or more persons have rights or obligations they are bound jointly and severally.',
    'This Privacy Policy (“Policy”) covers the types of information we collect and the ways we may collect, use and disclose your personal information (“Information”) if you choose to use the Fit24 application and/or website (our “Service”).\nBy using our Service, you confirm that you agree to the collection and use of information in accordance with this Policy. The Personal Information that we collect is used for providing and improving the Service. We will not use your Information in any other way or share your Information with anyone except as described in this Policy.\nThis Policy is part of our Terms and Conditions, which is accessible through the App and on our Website.\nInformation Collection and Use\nFor a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to IDFA. The information that we request will be retained by us and used as described in this Policy.\nThe app uses third party services that may collect information used to identify you. Please refer to their respective privacy policies for details on how they handle personal information:\nGoogle Play Services\nFirebase Analytics\nFirebase Crashlytics\nFacebook\nFlurry Analytics\nLog Data\nWe want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.\nCookies\nCookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored in your device\'s internal memory.\nThis Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse cookies, you may not be able to use some portions of this Service.\nService Providers\nWe may employ third-party companies and individuals due to the following reasons:\nTo facilitate our Service;\nTo provide the Service on our behalf;\nTo perform Service-related services; or\nTo assist us in analyzing how our Service is used.\nWe want to inform users of this Service that these third parties have access to your Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.\nSecurity\nWe value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.\nLinks to Other Sites\nThis Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.\nChildren’s Privacy\nThis Service is not meant for anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to take necessary actions.\nChanges to This Privacy Policy\nWe may update this Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page.\nContact Us\nIf you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at support@outbyte.com',];

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 52*UIScaler.getUiScaleFactor(context), left: 16*UIScaler.getUiScaleFactor(context), right: 16*UIScaler.getUiScaleFactor(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50*UIScaler.getUiScaleFactor(context),
              child: Stack(
                children: <Widget>[
                  GestureDetector(onTap: (){Navigator.pop(context);}, child: Align(alignment: Alignment.centerLeft, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/img/back_arrow.png', height: 13, width: 20,),
                  ))),
                  Align(alignment: Alignment.center , child: Text(listTitle[args.index] , style: TextStyleBuilder.textStyleBuilder(16, 500, TextStyleColors.darkBlack, FontStyle.normal, context), textAlign: TextAlign.center,)),
                ],),
            ),
            Container(height: MediaQuery.of(context).size.height - 150*UIScaler.getUiScaleFactor(context),child: SingleChildScrollView(child: Text(listBody[args.index] , style: TextStyleBuilder.textStyleBuilder((14*UIScaler.getUiScaleFactor(context)).toInt(), 300, TextStyleColors.darkBlack, FontStyle.normal, context), textAlign: TextAlign.start,)))
          ],
        ),
      ),
    );
  }
}

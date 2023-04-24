import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthsim/questionnaire/ModelAnswer.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../algorithm/algo.dart';

class PDFPreviewCustom extends StatefulWidget {
  ModelAnswer resultQuestionnaire;
  PDFPreviewCustom({super.key, required this.resultQuestionnaire});

  @override
  State<PDFPreviewCustom> createState() => _PDFPreviewCustomState();
}

class _PDFPreviewCustomState extends State<PDFPreviewCustom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        maxPageWidth: 1000,
        build: (format) => _createPDF(),
      ),
    );
  }

  /* void */ Future<Uint8List> _createPDF() async {
    final doc = pw.Document();
    var alimText = [
      AppLocalizations.of(context)!.answeralim0,
      AppLocalizations.of(context)!.answeralim1,
      AppLocalizations.of(context)!.answeralim2,
      AppLocalizations.of(context)!.answeralim3
    ];
    var sportText = [
      AppLocalizations.of(context)!.answersport0,
      AppLocalizations.of(context)!.answersport1,
      AppLocalizations.of(context)!.answersport2,
      AppLocalizations.of(context)!.answersport3
    ];
    var alcoolText = [
      AppLocalizations.of(context)!.answeralcool0,
      AppLocalizations.of(context)!.answeralcool1,
      AppLocalizations.of(context)!.answeralcool2,
      AppLocalizations.of(context)!.answeralcool3,
      AppLocalizations.of(context)!.answeralcool4
    ];

    var gender = "",
        glyc = "",
        syst = "",
        chol = "",
        diab = "",
        inf = "",
        avc = "",
        afinf = "",
        afcancer = "",
        smoke = "",
        alim = alimText.elementAt(widget.resultQuestionnaire.alim),
        sport = sportText.elementAt(widget.resultQuestionnaire.sport),
        alcool = alcoolText.elementAt(widget.resultQuestionnaire.alcool);

    if (widget.resultQuestionnaire.gender == 1) {
      gender = AppLocalizations.of(context)!.questionnairegenderanswerpositive;
    } else {
      gender = AppLocalizations.of(context)!.questionnairegenderanswernegative;
    }
    if (widget.resultQuestionnaire.glyc == 1) {
      glyc = AppLocalizations.of(context)!.answerpositive;
    } else {
      glyc = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.syst == 1) {
      syst = AppLocalizations.of(context)!.answerpositive;
    } else {
      syst = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.chol == 1) {
      chol = AppLocalizations.of(context)!.answerpositive;
    } else {
      chol = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.diab == 1) {
      diab = AppLocalizations.of(context)!.answerpositive;
    } else {
      diab = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.inf == 1) {
      inf = AppLocalizations.of(context)!.answerpositive;
    } else {
      inf = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.avc == 1) {
      avc = AppLocalizations.of(context)!.answerpositive;
    } else {
      avc = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.afinf == 1) {
      afinf = AppLocalizations.of(context)!.answerpositive;
    } else {
      afinf = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.afcancer == 1) {
      afcancer = AppLocalizations.of(context)!.answerpositive;
    } else {
      afcancer = AppLocalizations.of(context)!.answernegative;
    }
    if (widget.resultQuestionnaire.smoke == 1) {
      smoke = AppLocalizations.of(context)!.answerpositive;
    } else {
      smoke = AppLocalizations.of(context)!.answernegative;
    }

    var questionsTitle = AppLocalizations.of(context)!.printtitlequestion,
        answerTitle = AppLocalizations.of(context)!.printtitleanswer;

    var genderTitle = AppLocalizations.of(context)!.questionnairegendertitle,
        ageTitle = AppLocalizations.of(context)!.questionnaireagetitle,
        heightTitle = AppLocalizations.of(context)!.questionnaireheighttitle,
        weightTitle = AppLocalizations.of(context)!.questionnaireweighttitle,
        glycTitle = AppLocalizations.of(context)!.questionnaireglyctitle,
        highSystTitle =
            AppLocalizations.of(context)!.questionnairehighsysttitle,
        highCholTitle =
            AppLocalizations.of(context)!.questionnairehighcholtitle,
        diabTitle = AppLocalizations.of(context)!.questionnairediabtitle,
        infTitle = AppLocalizations.of(context)!.questionnaireinftitle,
        avcTitle = AppLocalizations.of(context)!.questionnaireavctitle,
        afinfTitle = AppLocalizations.of(context)!.questionnaireafinftitle,
        afcancerTitle =
            AppLocalizations.of(context)!.questionnaireafcancertitle,
        smokeTitle = AppLocalizations.of(context)!.questionnairesmoketitle,
        alimTitle = AppLocalizations.of(context)!.questionnairealimtitle,
        sportTitle = AppLocalizations.of(context)!.questionnairesporttitle,
        alcoolTitle = AppLocalizations.of(context)!.questionnairealcooltitle;

    var riskTitle = AppLocalizations.of(context)!.resulttitle,
        cancerRiskTitle = AppLocalizations.of(context)!.resultcancerrisktitle,
        avcRiskTitle = AppLocalizations.of(context)!.resultinfrisktitle,
        diabeteRiskTitle = AppLocalizations.of(context)!.resultdiabrisktitle;

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Table(columnWidths: const <int, pw.TableColumnWidth>{
            0: pw.FlexColumnWidth(),
            1: pw.FixedColumnWidth(20),
            2: pw.FixedColumnWidth(100),
          }, children: [
            pw.TableRow(children: [
              pw.Text("HealtSim",
                  style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900)),
              pw.SizedBox(width: 10),
              pw.Text(""),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 30)]),
            pw.TableRow(children: [
              pw.Text(questionsTitle,
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900)),
              pw.SizedBox(width: 10),
              pw.Text(answerTitle,
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900))
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 20)]),
            pw.TableRow(children: [
              pw.Text(genderTitle),
              pw.SizedBox(width: 10),
              pw.Text(gender),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(ageTitle),
              pw.SizedBox(width: 10),
              pw.Text(widget.resultQuestionnaire.age.toString()),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(heightTitle),
              pw.SizedBox(width: 10),
              pw.Text(widget.resultQuestionnaire.height.toString()),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(weightTitle),
              pw.SizedBox(width: 10),
              pw.Text(widget.resultQuestionnaire.weight.toString())
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(glycTitle),
              pw.SizedBox(width: 10),
              pw.Text(glyc),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(highSystTitle),
              pw.SizedBox(width: 10),
              pw.Text(syst),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(highCholTitle),
              pw.SizedBox(width: 10),
              pw.Text(chol),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(diabTitle),
              pw.SizedBox(width: 10),
              pw.Text(diab),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(infTitle),
              pw.SizedBox(width: 10),
              pw.Text(inf),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(avcTitle),
              pw.SizedBox(width: 10),
              pw.Text(avc),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(afinfTitle),
              pw.SizedBox(width: 10),
              pw.Text(afinf),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(afcancerTitle),
              pw.SizedBox(width: 10),
              pw.Text(afcancer),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(smokeTitle),
              pw.SizedBox(width: 10),
              pw.Text(smoke),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(alimTitle),
              pw.SizedBox(width: 10),
              pw.Text(alim),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(sportTitle),
              pw.SizedBox(width: 10),
              pw.Text(sport),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(alcoolTitle),
              pw.SizedBox(width: 10),
              pw.Text(alcool),
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [pw.SizedBox(height: 20)]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(riskTitle,
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900)),
              pw.SizedBox(width: 10),
              pw.Text("")
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 20)]),
            pw.TableRow(children: [
              pw.Text(cancerRiskTitle),
              pw.SizedBox(width: 10),
              pw.Text("${riskCancer(widget.resultQuestionnaire).toString()} %")
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(avcRiskTitle),
              pw.SizedBox(width: 10),
              pw.Text("${riskAVC(widget.resultQuestionnaire).toString()} %")
            ]),
            pw.TableRow(children: [pw.SizedBox(height: 5)]),
            pw.TableRow(children: [
              pw.Text(diabeteRiskTitle),
              pw.SizedBox(width: 10),
              pw.Text("${riskDiabete(widget.resultQuestionnaire).toString()} %")
            ]),
          ]); // Center
        }));
    return doc.save();
    /* await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save()); */
  }
}

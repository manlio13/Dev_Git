�
 TFORM1 0�  TPF0TForm1Form1Left� TopaWidthaHeight2HintRegistro Ed.1.0 betaActiveControlPanel1CaptionE                        Sistema di catalogazione                     
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style PixelsPerInch`ShowHint	OnCreate
FormCreate
TextHeight TPanelPanel1Left Top WidthYHeight)AlignalTopColorclSilverTabOrder  TDBNavigatorDBNavigatorLeft&TopWidth� Height
DataSourceDataSource1VisibleButtonsnbFirstnbPriornbNextnbLast Ctl3DParentCtl3DTabOrder    TPanelPanel2Left Top)WidthYHeight� AlignalClient
BevelInner	bvLoweredBorderWidthCaptionPanel2TabOrder 
TScrollBox	ScrollBoxLeftTopWidthMHeight� HorzScrollBar.MarginHorzScrollBar.Range8VertScrollBar.MarginVertScrollBar.RangeRAlignalClient
AutoScrollBorderStylebsNoneColor	clBtnFace
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.Style ParentColor
ParentFontParentShowHintShowHintTabOrder  TLabelLabel1LeftTopWidthHeightCaptionCodFocusControlEditCod  TLabelLabel3LeftTopLWidthrHeightCaptionRicerca per argomento :  TLabelLabel2LeftTop*Width3HeightCaption	ArgomentoFocusControlEditArgomento  TLabelLabel6Left&Top Width#HeightCaptionML-1997
Font.ColorclBlackFont.Height�	Font.NameSmall Fonts
Font.Style 
ParentFont  	TGroupBox	GroupBox1LeftTop|WidthGHeightcCaption&Per inserire o modificare o cancellareColorclScrollBar
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold ParentColor
ParentFontTabOrder TLabelLabel4LeftTopWidthHeightCaptionCodFocusControlEditCod  TLabelLabel5LeftTop4Width=HeightCaption	ArgomentoFocusControlEditCod  TButton	BcancellaLeftTopWidthHeightCaption-
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickBcancellaClick  TButton	BaggiungiLeft� TopWidthHeightCaption+
Font.ColorclBlackFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickBaggiungiClick  TBitBtnmodificaLeft� TopWidthKHeightCaptionmodifica
Font.ColorclBlackFont.Height�	Font.NameArial
Font.Style 
ParentFontTabOrderOnClickmodificaClick
Glyph.Data
|  x  BMx      v   (                                      �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 333     333wwwww333����?���??� 0  � �w�ww?sw7������ws3?33�࿿ ���w�3ws��7�������w�3?��7࿿  �w�3wwss7��������w�?���37�   ��w�wwws?� � �� �ws�w73w730 ���37wss3?�330���  33773�ww33��33s7s730���37�33s3	�� 33ws��w3303   3373wwws3  	NumGlyphs  TEditedit2LeftTopWidthQHeightHintmax 10 caratteri	MaxLength
ParentShowHintShowHint	TabOrder   TEditEdit3LeftTopDWidthHeightHintmax 80 caratteri	MaxLengthPParentShowHintShowHint	TabOrder   TDBEditEditCodLeftTopWidthUHeight	DataFieldCod
DataSourceDataSource1	MaxLength TabOrderOnClickEditCodClick  TDBEditEditArgomentoLeftTop9Width,Height	DataField	Argomento
DataSourceDataSource1	MaxLength TabOrderOnClickEditArgomentoClick  TEditedit1LeftTop\Width� HeightHint'inserire il testo o parte, da ricercareParentShowHintShowHint	TabOrder   TBitBtnBitBtn1Left� TopZWidthCHeightCaptioncercaTabOrderOnClickBitBtn1Click
Glyph.Data
z  v  BMv      v   (                                     �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 333333333333333�3333330 ?����37w 0  330 w�ww?37w���333ws3?33?࿿ 33 w�3ws�3w�����33 w�3?���w࿿   33w�3www??�������w�?���sw�    3�w�wwww3w �3333ws�s333?30 3333 37w3333w3333333 3333333w333333333333333�3333330 3333337w3333330 3333337w3333333333333333	NumGlyphs  TButtonhelpLeft� TopWidthHeightHinthelp !CaptionH
Font.ColorclRedFont.Height�	Font.NameArial
Font.Style 
ParentFontParentShowHintShowHint	TabOrderOnClick	helpClick    TQueryQuery1DatabaseName.\SQL.StringsSelect * from di RequestLive	LeftTop  TDataSourceDataSource1DataSetQuery1LeftTop  TQueryupdatequeryDatabaseName.\SQL.Strings	UPDATE DISET COD= :COD,ARGOMENTO= :ARGWHERE COD= :CODMOD  Params.Data
(     COD     ARG     CODMOD     Left>Top  TQueryaggiungiDatabaseName.\SQL.Strings1INSERT INTO DI (COD, ARGOMENTO) VALUES(:COD,:ARG) 
DataSourceDataSource1Params.Data
     COD     ARG     Left� Top  TQueryCancellaSQL.StringsDELETE FROM DI WHERE COD= :C AND ARGOMENTO = :A Params.Data
     C     A     Left� Top  TTimerTimer1EnabledIntervalFOnTimertimer1timerLeftTop   
HelpScribble project file.
16
Znayvb Ynfpuran-07NP42
0
2
Helpdesk


MLSoft 2013
FALSE
0x0409   English (U.S.)
C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2013\HlpDesk\Hlp
1
BrowseButtons()
0
FALSE
C:\Users\Manlio Laschena\Documents\RAD Studio\Projects\2013\HlpDesk\Hlp\
FALSE
TRUE
16777215
0
16711680
8388736
255
TRUE
FALSE
FALSE
FALSE
150
50
600
500
TRUE
FALSE
1
FALSE
FALSE
Contents
%s Contents
Index
%s Index
Previous
Next
FALSE

7
10
Scribble10
Overview
Fast start;Overview;



Writing



FALSE
13
{\rtf1\ansi\ansicpg1252\deff0\deflang1040{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;\red128\green0\blue0;}
\viewkind4\uc1\pard\cf1\b\fs32 Overview\cf2\{keepn\}\cf1 
\par \cf2\b0\fs20 The application is intended to offer to the user a simple platform to record the actions in progress, scheduling followup, sending email and organizing the archive of events.
\par All the above is possible thanks to few tables under a single database set.
\par 
\par A fast starting may be understood just giving a look to the following image.\f1 
\par 
\par \{bmc HelpDesk.bmp\}\cf0 
\par 
\par 
\par 
\par }
20
Scribble20
New record
Autocomplete;Filed;new record;post a record;Status;Tag;Time;What;



Writing



FALSE
18
{\rtf1\ansi\ansicpg1252\deff0\deflang1040{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;\red128\green0\blue0;}
\viewkind4\uc1\pard\cf1\b\fs32 New record\cf2\{keepn\}\cf0\b0\f1\fs20 
\par 
\par \f0 To add a new record you must click on the "+" box of the navigator bar (see the picture).
\par 
\par \cf2\{bmc addNR.bmp\}\cf0 
\par 
\par Automatically the "Filed" field of a new record will be filled up with today date, and the "Time" field will show the actual time. Both data can be manually edited.
\par 
\par The "what" field can be edited with a short description of the event to be recorded.
\par Automatically the "Status" field will be filled up with default "In progress" string. Also this field can be edited. After the post record action, any new
\par Status string will be saved in the Status table.
\par To complete the first phase of record entry, "Tag" field must be filled with an appropriate value to help categorize the event.
\par Any new tag, after post action, will be store in the Tag table.
\par Autocomplete of Status and Tag can be achieved by a double click on the string to be used, just on the lists shown respectively on Status and Tag tables. The double clicked string will be copied in the main record corresponding fields.
\par After entry of the Tag field the record is automatically posted. In case can be manually posted clicking on the check box of the navigator bar.\f1 
\par }
30
Scribble30
More Memo
Memo;Memo Editor;More;



Writing



FALSE
12
{\rtf1\ansi\ansicpg1252\deff0\deflang1040{\fonttbl{\f0\fnil Arial;}{\f1\fnil\fcharset0 Arial;}}
{\colortbl ;\red0\green0\blue255;\red128\green0\blue0;}
\viewkind4\uc1\pard\cf1\b\f0\fs32 More Memo\{keepn\}\cf2\b0\fs20 
\par \cf0\f1 After the first contact, where it's possible to record few note about the coming event, it's possible to generate an additional editing area
\par where more informations can be recorded.
\par 
\par \cf2\{bmc Memo.bmp\}\cf0 
\par 
\par AS it's evident in the picture, the new window is generated clicking on the little box arount the Memo field, just where the word "More" can be read.
\par The window will appear with the Time Stamp showing the actual timinig.
\par In that window it's possible to write down and store all the information about requests, action to be taken and, as will be explained in the next pages, also the text of emails to be sent with the default email Client.\f0 
\par }
40
Scribble40
Email
Address Book;Contacts;email;Email Client;Select;



Writing



FALSE
24
{\rtf1\ansi\ansicpg1252\deff0\deflang1040{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;\red128\green0\blue0;}
\viewkind4\uc1\pard\cf1\b\fs32 Email\cf2\{keepn\}\cf1 
\par \cf0\b0\f1\fs20 
\par \f0 It is possible to send email, using the default Email Client, and writing directly inside HelpDesk.
\par 
\par To do so, select the record involved with the email sending, click on the box "More" in order to call the MEMO window.
\par Within that window, write the email body text. 
\par Select the text to be sent.
\par Exit the MemoEditor.
\par Click on the Send Email button.
\par \f1 
\par \f0 The default email client will pop up, with the text selected in the email body.
\par Write the recipient address and subject and send the email.
\par In case HelpDesk gives the possibility to call the default email Address Book to get the recipient address if unknown.
\par 
\par Following pictures may help to step by step action.
\par 
\par \cf2\{bmc selected.bmp\}\cf0 
\par 
\par \cf2\{bmc client.bmp\}\cf0 
\par 
\par \cf2\{bmc sent.bmp\}\cf0\f1 
\par }
50
Scribble50
Filtering
Filter,Clear filter,LED;AND;Status;Tag;What;Filed;



Writing



FALSE
13
{\rtf1\ansi\ansicpg1252\deff0\deflang1040{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;\red128\green0\blue0;}
\viewkind4\uc1\pard\cf1\b\fs32 Filtering\cf2\{keepn\}\cf0\b0\f1\fs20 
\par \f0 
\par Overview: 
\par Filter action, done with the purpose to find a specific record, can be obtained specifying the (even partial) content of four fields.
\par 
\par \cf2\{bmc Filter.bmp\}\cf0 
\par 
\par The filter works on an AND basis, i.e. it will produce the record with ALL the selected values. 
\par The field "Filed" (date) and the field "What" (using also a partial string) will be set writing in the relative edit windows, determining the corresponding LED to switch to red color. For inserting a filter based on "Status" or "Tag" click on the underlaying "filter selected" buttons. To clear the filter must be used the "Clear filter" button.
\par Once the filter structure (one to four selected fields) has been set: the filter works clicking on Run Filter button.\f1 
\par }
60
Scribble60
Ticket
Ticket;Date ticket setting board;SetDate;Reset;Action;Clear



Writing



FALSE
16
{\rtf1\ansi\ansicpg1252\deff0\deflang1040{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;\red128\green0\blue0;}
\viewkind4\uc1\pard\cf1\b\fs32 Ticket\cf2\{keepn\}
\par \{bmc ticket.bmp\}
\par \cf0\b0\f1\fs20 
\par \f0 HelpDesk with "Date ticket setting board" gives the possibility to issue a sort of ticket. 
\par What there is behind ? Each time a new main record is created it is linked to a unique code number. At the mean time it's created a new record in the Date ticketing system with the same code number.
\par By means of this second table it is possible, just on the Date ticket setting board to set a date ticket where the main record will receive a call for action. So it will be possible to schedule some activity to be done on a planned date.
\par To issue a ticket scroll to the record having the same "code" of the main record to be scheduled.
\par Fill the date and push the "SetDate" button. The "Set" field will show True and the LED will flash red.
\par The date can be reset with the "Reset" button, that works only on the selected field. 
\par Clicking on the "Filter" button, all the record with a date set will be shown.
\par "Clear" will reset the above filtering action.
\par The "Action" button will link to the main record, having the same code number of the selected board's record. \f1 
\par 
\par }
70
Scribble70
Report - Print
Report;Print



Writing



FALSE
8
{\rtf1\ansi\ansicpg1252\deff0\deflang1040{\fonttbl{\f0\fnil\fcharset0 Arial;}{\f1\fnil Arial;}}
{\colortbl ;\red0\green0\blue255;\red128\green0\blue0;}
\viewkind4\uc1\pard\cf1\b\fs32 Report - Print\cf2\{keepn\}\cf0\b0\f1\fs20 
\par 
\par \f0 HelpDesk has a "Report" button, that provides with a full report of all the written string issued for a selected main record.
\par The report is automatically copied to the clipboard, in order to allow a free use by means of any word edit application.
\par If you click on the print button it's possible to get a printing out.\f1 
\par }
0
0
0
7
1 Overview=Scribble10
2 New record=Scribble20
2 More Memo=Scribble30
2 Email=Scribble40
2 Filtering=Scribble50
2 Ticket=Scribble60
2 Report - Print=Scribble70
6
*InternetLink
16711680
Courier New
0
10
1
....
0
0
0
0
0
0
*ParagraphTitle
-16777208
Arial
0
11
1
B...
0
0
0
0
0
0
*PopupLink
-16777208
Arial
0
8
1
....
0
0
0
0
0
0
*PopupTopicTitle
16711680
Arial
0
10
1
B...
0
0
0
0
0
0
*TopicText
-16777208
Arial
0
10
1
....
0
0
0
0
0
0
*TopicTitle
16711680
Arial
0
16
1
B...
0
0
0
0
0
0

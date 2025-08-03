#heading("Figures, tables and images") <chap-3>

#heading(level: 2, "Figures")

#figure(
  image("../images/chap3/emblem.jpg", width: 30%),
  caption: [Full caption with all the details here.font size has to be 10pt, and sentences has to be left side.],
) <fig-example>

#figure(
  image("../images/chap3/symbol.jpg", width: 30%),
  caption: [This secret image won't be numbered and won't appear in the List of Figures because of the \*],
  supplement: none,
)

Refer to figure like this: Figure @fig-example or this (Fig. @fig-example). If you want to include a list of figure, you can use a short version of the caption as shown in Figure @fig-example.

#heading(level: 2, "Tables")

#figure(
  table(
    columns: (auto, auto),
    align: (center, center),
    [Parameter], [Value],
    line(length: 100%), line(length: 100%),
    $Delta$, "0, 150",
    $alpha$, "85",
    $epsilon$, "6",
    $kappa$, "6.8",
    $gamma$, "0.2",
  ),
  caption: [Short heading for the List of Tables.],
) <tab-values>

#figure(
  table(
    columns: (auto, auto),
    align: (center, center),
    [Parameter], [Value],
    line(length: 100%), line(length: 100%),
    $Delta$, "0, 1500",
    $alpha$, "850",
    $epsilon$, "60",
    $kappa$, "68",
    $gamma$, "2",
  ),
  caption: [This secret table won't be numbered and won't appear in the List of Figures because of the \*],
  supplement: none,
)

Refer to tables this this: Table @tab-values.

Table titles should be under the tables.

Visual of LaTeX's tables are beautiful, however inputting all tables manually was too much for me. So, I just created pictures of tables on power point by copy and paste from excel table. Then, inserted them into tables. I wish this way helps for chemists and biologist who utilize many tables.

#figure(
  image("../images/chap3/TimeConversion.png", width: 50%),
  caption: [Example of Time Expression: Example of time expressed in AM/PM, 24-hour time (military time) and hour of day format. Feeding time which were originally military time format were converted to decimal time format (hour of day) for XX regression.],
) <Timeconversion>

#figure(
  image("../images/chap3/TableExample.png", width: 100%),
  caption: [Statistic Characterization of Meteorological Data: P-values were calculated using Kruskal-Wallis tests across months. Significant differences were identified at a false discovery rate -adjusted p-value < 0.05.],
) <table:Env_statistics>

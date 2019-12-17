   1.
      /**
   2.
       *  Progress Bar 1.3.1.0
   3.
       *  Copyright 2007-2010 Infernus' Group,
   4.
       *  Flávio Toribio (flavio_toibio@hotmail.com)
   5.
       */
   6.

   7.
      #if defined _progress_included
   8.
              #endinput
   9.
      #endif
  10.

  11.
      #if !defined _samp_included
  12.
              #tryinclude <a_samp>
  13.
              #if !defined _samp_included
  14.
                      #error could not locate a_samp.inc file, please check your server includes
  15.
              #endif
  16.
      #endif
  17.

  18.
      #tryinclude <foreach>
  19.

  20.
      #define _progress_included
  21.
      #define _progress_version       0x1310
  22.

  23.
      #define MAX_BARS                                (MAX_TEXT_DRAWS / 3)
  24.
      #define INVALID_BAR_VALUE               (Float:0xFFFFFFFF)
  25.
      #define INVALID_BAR_ID                  (Bar:-1)
  26.
      #define pb_percent(%1,%2,%3,%4) ((%1 - 6.0) + ((((%1 + 6.0 + %2 - 2.0) - %1) / %3) * %4))
  27.
      //pb_percent(x, width, max, value)
  28.

  29.
      /* Pawno/Infernus Pawn Editor function list
  30.
      native Bar:CreateProgressBar(Float:x, Float:y, Float:width=55.5, Float:height=3.2, color, Float:max=100.0);
  31.
      native DestroyProgressBar(Bar:barid);
  32.
      native ShowProgressBarForPlayer(playerid, Bar:barid);
  33.
      native HideProgressBarForPlayer(playerid, Bar:barid);
  34.
      native ShowProgressBarForAll(Bar:barid);
  35.
      native HideProgressBarForAll(Bar:barid);
  36.
      native SetProgressBarValue(Bar:barid, Float:value);
  37.
      native Float:GetProgressBarValue(Bar:barid);
  38.
      native SetProgressBarMaxValue(Bar:barid, Float:max);
  39.
      native SetProgressBarColor(Bar:barid, color);
  40.
      native UpdateProgressBar(Bar:barid, playerid=INVALID_PLAYER_ID);
  41.
      */
  42.

  43.
      forward Bar:CreateProgressBar(Float:x, Float:y, Float:width=55.5, Float:height=3.2, color, Float:max=100.0);
  44.
      forward Float:GetProgressBarValue(Bar:barid);
  45.

  46.
      enum e_bar
  47.
      {
  48.
              Float:pb_x,
  49.
              Float:pb_y,
  50.
              Float:pb_w,
  51.
              Float:pb_h,
  52.
              Float:pb_m,
  53.
              Float:pb_v,
  54.
              Text:pb_t1,
  55.
              Text:pb_t2,
  56.
              Text:pb_t3,
  57.
              pb_color,
  58.
              bool:pb_created
  59.
      }
  60.

  61.
      static Bars[MAX_BARS][e_bar];
  62.

  63.
      stock Bar:CreateProgressBar(Float:x, Float:y, Float:width=55.5, Float:height=3.2, color, Float:max=100.0)
  64.
      {
  65.
              new
  66.
                      barid;
  67.

  68.
              for(barid = 0; barid < sizeof Bars; ++barid)
  69.
                      if(!Bars[barid][pb_created]) break;
  70.

  71.
              if(Bars[barid][pb_created] || barid == sizeof Bars)
  72.
                      return INVALID_BAR_ID;
  73.

  74.
              new Text:in_t = Bars[barid][pb_t1] = TextDrawCreate(x, y, "_");
  75.
              TextDrawUseBox          (in_t, 1);
  76.
              TextDrawTextSize        (in_t, x + width, 0.0);
  77.
              TextDrawLetterSize      (in_t, 1.0, height / 10);
  78.
              TextDrawBoxColor        (in_t, 0x00000000 | (color & 0x000000FF));
  79.

  80.
              in_t = Bars[barid][pb_t2] = TextDrawCreate(x + 1.2, y + 2.15, "_");
  81.
              TextDrawUseBox          (in_t, 1);
  82.
              TextDrawTextSize        (in_t, x + width - 2.0, 0.0);
  83.
              TextDrawLetterSize      (in_t, 1.0, height / 10 - 0.35);
  84.
              TextDrawBoxColor        (in_t, (color & 0xFFFFFF00) | (0x66 & ((color & 0x000000FF) / 2)));
  85.

  86.
              in_t = Bars[barid][pb_t3] = TextDrawCreate(x + 1.2, y + 2.15, "_");
  87.
              TextDrawTextSize        (in_t, pb_percent(x, width, max, 1.0), 0.0);
  88.
              TextDrawLetterSize      (in_t, 1.0, height / 10 - 0.35);
  89.
              TextDrawBoxColor        (in_t, color);
  90.

  91.
              Bars[barid][pb_x] = x;
  92.
              Bars[barid][pb_y] = y;
  93.
              Bars[barid][pb_w] = width;
  94.
              Bars[barid][pb_h] = height;
  95.
              Bars[barid][pb_m] = max;
  96.
              Bars[barid][pb_color] = color;
  97.
              Bars[barid][pb_created] = true;
  98.
              return Bar:barid;
  99.
      }
 100.

 101.
      stock DestroyProgressBar(Bar:barid)
 102.
      {
 103.
              if(barid != INVALID_BAR_ID && Bar:-1 < barid < Bar:MAX_BARS)
 104.
              {
 105.
                      if(!Bars[_:barid][pb_created])
 106.
                              return 0;
 107.

 108.
                      TextDrawDestroy(Bars[_:barid][pb_t1]);
 109.
                      TextDrawDestroy(Bars[_:barid][pb_t2]);
 110.
                      TextDrawDestroy(Bars[_:barid][pb_t3]);
 111.

 112.
                      Bars[_:barid][pb_t1] = Text:0;
 113.
                      Bars[_:barid][pb_t2] = Text:0;
 114.
                      Bars[_:barid][pb_t3] = Text:0;
 115.
                      Bars[_:barid][pb_x] = 0.0;
 116.
                      Bars[_:barid][pb_y] = 0.0;
 117.
                      Bars[_:barid][pb_w] = 0.0;
 118.
                      Bars[_:barid][pb_h] = 0.0;
 119.
                      Bars[_:barid][pb_m] = 0.0;
 120.
                      Bars[_:barid][pb_v] = 0.0;
 121.
                      Bars[_:barid][pb_color] = 0;
 122.
                      Bars[_:barid][pb_created] = false;
 123.
                      return 1;
 124.
              }
 125.
              return 0;
 126.
      }
 127.

 128.
      stock ShowProgressBarForPlayer(playerid, Bar:barid)
 129.
      {
 130.
              if(IsPlayerConnected(playerid) && barid != INVALID_BAR_ID && Bar:-1 < barid < Bar:MAX_BARS)
 131.
              {
 132.
                      if(!Bars[_:barid][pb_created])
 133.
                              return 0;
 134.

 135.
                      TextDrawShowForPlayer(playerid, Bars[_:barid][pb_t1]);
 136.
                      TextDrawShowForPlayer(playerid, Bars[_:barid][pb_t2]);
 137.
                      TextDrawShowForPlayer(playerid, Bars[_:barid][pb_t3]);
 138.
                      return 1;
 139.
              }
 140.
              return 0;
 141.
      }
 142.

 143.
      stock HideProgressBarForPlayer(playerid, Bar:barid)
 144.
      {
 145.
              if(IsPlayerConnected(playerid) && barid != INVALID_BAR_ID && Bar:-1 < barid < Bar:MAX_BARS)
 146.
              {
 147.
                      if(!Bars[_:barid][pb_created])
 148.
                              return 0;
 149.

 150.
                      TextDrawHideForPlayer(playerid, Bars[_:barid][pb_t1]);
 151.
                      TextDrawHideForPlayer(playerid, Bars[_:barid][pb_t2]);
 152.
                      TextDrawHideForPlayer(playerid, Bars[_:barid][pb_t3]);
 153.
                      return 1;
 154.
              }
 155.
              return 0;
 156.
      }
 157.

 158.
      stock SetProgressBarValue(Bar:barid, Float:value)
 159.
      {
 160.
              if(barid == INVALID_BAR_ID || Bar:MAX_BARS < barid < Bar:-1)
 161.
                      return 0;
 162.

 163.
              if(Bars[_:barid][pb_created])
 164.
              {
 165.
                      value =
 166.
                              (value < 0.0) ? (0.0) : (value > Bars[_:barid][pb_m]) ? (Bars[_:barid][pb_m]) : (value);
 167.

 168.
                      TextDrawUseBox(Bars[_:barid][pb_t3], value > 0.0);
 169.

 170.
              Bars[_:barid][pb_v] = value;
 171.

 172.
                      TextDrawTextSize(Bars[_:barid][pb_t3],
 173.
                              pb_percent(Bars[_:barid][pb_x], Bars[_:barid][pb_w], Bars[_:barid][pb_m], value), 0.0);
 174.

 175.
                      return 1;
 176.
              }
 177.
              return 0;
 178.
      }
 179.

 180.
      stock Float:GetProgressBarValue(Bar:barid)
 181.
      {
 182.
              if(barid == INVALID_BAR_ID || Bar:MAX_BARS < barid < Bar:-1)
 183.
                      return INVALID_BAR_VALUE;
 184.

 185.
              if(Bars[_:barid][pb_created])
 186.
                      return Bars[_:barid][pb_v];
 187.

 188.
              return INVALID_BAR_VALUE;
 189.
      }
 190.

 191.
      stock SetProgressBarMaxValue(Bar:barid, Float:max)
 192.
      {
 193.
              if(barid == INVALID_BAR_ID || Bar:MAX_BARS < barid < Bar:-1)
 194.
                      return 0;
 195.

 196.
              if(Bars[_:barid][pb_created])
 197.
              {
 198.
                      Bars[_:barid][pb_m] = max;
 199.
                      SetProgressBarValue(barid, Bars[_:barid][pb_v]);
 200.
                      return 1;
 201.
              }
 202.
              return 0;
 203.
      }
 204.

 205.
      stock SetProgressBarColor(Bar:barid, color)
 206.
      {
 207.
              if(barid == INVALID_BAR_ID || Bar:MAX_BARS < barid < Bar:-1)
 208.
                      return 0;
 209.

 210.
              if(Bars[_:barid][pb_created])
 211.
              {
 212.
                      Bars[_:barid][pb_color] = color;
 213.
                      TextDrawBoxColor(Bars[_:barid][pb_t1], 0x00000000 | (color & 0x000000FF));
 214.

 215.
                      TextDrawBoxColor(Bars[_:barid][pb_t2],
 216.
                              (color & 0xFFFFFF00) | (0x66 & ((color & 0x000000FF) / 2)));
 217.

 218.
                      TextDrawBoxColor(Bars[_:barid][pb_t3], color);
 219.
                      return 1;
 220.
              }
 221.
              return 0;
 222.
      }
 223.

 224.
      stock ShowProgressBarForAll(Bar:barid)
 225.
      {
 226.
              #if defined _foreach_included
 227.
              foreach(Player, i)
 228.
              #else
 229.
              for(new i = 0; i < MAX_PLAYERS; ++i)
 230.
                      if(IsPlayerConnected(i))
 231.
              #endif
 232.
              #if defined IsPlayerNPC
 233.
                      if(!IsPlayerNPC(i))
 234.
              #endif
 235.
              {
 236.
                      ShowProgressBarForPlayer(i, barid);
 237.
              }
 238.
              return 1;
 239.
      }
 240.

 241.
      stock HideProgressBarForAll(Bar:barid)
 242.
      {
 243.
              #if defined _foreach_included
 244.
              foreach(Player, i)
 245.
              #else
 246.
              for(new i = 0; i < MAX_PLAYERS; ++i)
 247.
                      if(IsPlayerConnected(i))
 248.
              #endif
 249.
              #if defined IsPlayerNPC
 250.
                      if(!IsPlayerNPC(i))
 251.
              #endif
 252.
              {
 253.
                      HideProgressBarForPlayer(i, barid);
 254.
              }
 255.
              return 1;
 256.
      }
 257.

 258.
      stock UpdateProgressBar(Bar:barid, playerid=INVALID_PLAYER_ID)
 259.
      {
 260.
              if(playerid == INVALID_PLAYER_ID)
 261.
              {
 262.
                      return ShowProgressBarForAll(barid);
 263.
              } else {
 264.
                      return ShowProgressBarForPlayer(playerid, barid);
 265.
              }
 266.
      }

package com.slowfrog.qwop.ui;

import java.awt.Robot;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;

import com.slowfrog.qwop.ConsoleLog;
import com.slowfrog.qwop.Log;
import com.slowfrog.qwop.Qwopper;
import com.slowfrog.qwop.RunInfo;

public class Main {

  private static final Log LOG = new ConsoleLog();

  public static void main(String[] args) {
    int tries;
    int time;
    String str;

    try {
      tries = Integer.parseInt(args[0]);
      time = Integer.parseInt(args[1]);
      str = args[2];
    } catch (Exception e) {
      LOG.log("Expected arguments: [tries] [time] [program]");
      System.exit(2);
      return;
    }

    try {
      Robot rob = new Robot();
      Qwopper qwop = new Qwopper(rob, LOG);
      qwop.findRealOrigin();

      for (int i = 0; i < tries; i++) {
        qwop.startGame();
        RunInfo info = qwop.playOneGame(str, time);
        System.out.println(String.format("%d;%d;%f", info.crashed ? 0 : 1, info.duration, info.distance));
      }
    } catch (Throwable t) {
      LOG.log("err;" + t.getMessage());
      System.exit(1);
    }
  }

}

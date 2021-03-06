package admm.trials

import collection.immutable.HashMap
import admm.util.ListHelper.list2helper
import admm.opt.SLRConfig

/**
 * User: jdr
 * Date: 5/7/12
 * Time: 5:11 PM
 */

trait KeywordLaunchable extends Launchable {
  def launchWithKeywords(kws: Map[String, String])

  def launch(args: Array[String]) {
    val kws = HashMap(args.toList.chunk(2).map(lst => lst.head -> lst.last): _*)
    launchWithKeywords(kws)
  }

}

trait SLRLaunchable extends KeywordLaunchable {
  def launchWithKeywords(kws: Map[String, String]) {
    val conf = new SLRConfig
    kws.get("nd") match {
      case Some(ans) => conf.nDocs = ans.toInt
      case None => "pass"
    }
    kws.get("nf") match {
      case Some(ans) => conf.nFeatures = ans.toInt
      case None => "pass"
    }
    kws.get("sd") match {
      case Some(ans) => conf.startDoc = ans.toInt
      case None => "pass"
    }
    kws.get("sf") match {
      case Some(ans) => conf.startFeature = ans.toInt
      case None => "pass"
    }
    kws.get("ns") match {
      case Some(ans) => conf.nSlices = ans.toInt
      case None => "pass"
    }
    kws.get("ni") match {
      case Some(ans) => conf.nIters = ans.toInt
      case None => "pass"
    }
    kws.get("lam") match {
      case Some(ans) => conf.lam = ans.toDouble
      case None => "pass"
    }
    kws.get("rho") match {
      case Some(ans) => conf.rho = ans.toDouble
      case None => "pass"
    }
    kws.get("atol") match {
      case Some(ans) => conf.absTol = ans.toDouble
      case None => "pass"
    }
    kws.get("rtol") match {
      case Some(ans) => conf.relTol = ans.toDouble
      case None => "pass"
    }
    kws.get("fn") match {
      case Some(ans) => conf.setOutput(ans)
      case None => "pass"
    }
    launchWithConfig(kws, conf)
  }
  def launchWithConfig(kws: Map[String, String], conf: SLRConfig)

}
#if !display
class GitCommit
{
    /**
     * Get the SHA1 hash of the current Git commit.
     */
    public static macro function getGitCommitHash():haxe.macro.Expr.ExprOf<String>
    {
      #if !display
      // Get the current line number.
      var pos = haxe.macro.Context.currentPos();
  
      var process = new sys.io.Process('git', ['rev-parse', 'HEAD']);
      if (process.exitCode() != 0)
      {
        var message = process.stderr.readAll().toString();
        haxe.macro.Context.info('[WARN] Could not determine current git commit; is this a proper Git repository?', pos);
      }
  
      // read the output of the process
      var commitHash:String = process.stdout.readLine();
      var commitHashSplice:String = commitHash.substr(0, 7);
  
      // Generates a string expression
      return macro $v{commitHashSplice};
      #else
      // `#if display` is used for code completion. In this case returning an
      // empty string is good enough; We don't want to call git on every hint.
      var commitHash:String = "";
      return macro $v{commitHashSplice};
      #end
    }
    
  /**
   * Get the SHA1 hash of the current Git commit.
   */
  public static macro function getGitRepoName():haxe.macro.Expr.ExprOf<String>
    {
      #if !display
      // Get the current line number.
      var pos = haxe.macro.Context.currentPos();
      var repoName:String = "";
  
      var process = new sys.io.Process('git', ['config', '--local', 'remote.origin.url']);
      if (process.exitCode() != 0)
      {
        var message = process.stderr.readAll().toString();
        haxe.macro.Context.info('[WARN] Could not determine current git commit; is this a proper Git repository?', pos);
      } else {
  
        // read the output of the process
        var fullUrl:String = process.stdout.readLine();
        repoName = fullUrl.substr(19, fullUrl.length);
        repoName = repoName.substr(0, repoName.length - 4);
      }
      return macro $v{repoName};
      #else
      // `#if display` is used for code completion. In this case returning an
      // empty string is good enough; We don't want to call git on every hint.
      var repoName:String = "";
      return macro $v{repoName};
      #end
    }

  /**
   * Get the branch name of the current Git commit.
   */
  public static macro function getGitBranch():haxe.macro.Expr.ExprOf<String>
  {
    #if !display
    // Get the current line number.
    var pos = haxe.macro.Context.currentPos();
    var branchProcess = new sys.io.Process('git', ['rev-parse', '--abbrev-ref', 'HEAD']);

    if (branchProcess.exitCode() != 0)
    {
      var message = branchProcess.stderr.readAll().toString();
      haxe.macro.Context.info('[WARN] Could not determine current git commit; is this a proper Git repository?', pos);
    }

    var branchName:String = branchProcess.stdout.readLine();

    // Generates a string expression
    return macro $v{branchName};
    #else
    // `#if display` is used for code completion. In this case returning an
    // empty string is good enough; We don't want to call git on every hint.
    var branchName:String = "";
    return macro $v{branchName};
    #end
  }

  /**
   * Get whether the local Git repository is dirty or not.
   */
  public static macro function getGitHasLocalChanges():haxe.macro.Expr.ExprOf<Bool>
  {
    #if !display
    // Get the current line number.
    var pos = haxe.macro.Context.currentPos();
    var branchProcess = new sys.io.Process('git', ['status', '--porcelain']);

    if (branchProcess.exitCode() != 0)
    {
      var message = branchProcess.stderr.readAll().toString();
      haxe.macro.Context.info('[WARN] Could not determine current git commit; is this a proper Git repository?', pos);
    }

    var output:String = '';
    try
    {
      output = branchProcess.stdout.readLine();
    }
    catch (e)
    {
      if (e.message == 'Eof')
      {
        // Do nothing.
        // Eof = No output.
      }
      else
      {
        // Rethrow other exceptions.
        throw e;
      }
    }

    // Generates a string expression
    return macro $v{output.length > 0};
    #else
    // `#if display` is used for code completion. In this case we just assume true.
    return macro $v{true};
    #end
  }
}
#end
import sys.io.File;
import sys.FileSystem;
import haxe.xml.Access;

using StringTools;

class Main {
    private static function recursiveDelete(path:String) {
		for(file in FileSystem.readDirectory(path)) {
			var p = '$path/$file';
			if(FileSystem.isDirectory(p))
				recursiveDelete(p);
			else
				FileSystem.deleteFile(p);
		}
		FileSystem.deleteDirectory(path);
	}

	public static function main() {

        var platform = switch(Sys.systemName()) {
			case "Windows": "windows";
			case "Mac": "mac";
			case "Linux": "linux";
			case def: def.toLowerCase();
		}
        
		var libsFile = new Access(Xml.parse(File.getContent("./installer/libs.xml")).firstElement());

        if (FileSystem.exists(".haxelib")) {
            //recursiveDelete(".haxelib");
        } else {
            FileSystem.createDirectory(".haxelib");
        }

        for (node in libsFile.elements)
        {
            switch (node.x.nodeName)
            {
                case "lib":
                    var version = node.has.version ? node.att.version : "";
                    Sys.println("");
                    Sys.println('Installing ${node.att.name}@${version.trim() == "" ? "latest" : version} from haxelib');
                    Sys.println("");
                    Sys.command('haxelib install ${node.att.name} $version --always --skip-dependencies');
                case "git":
                    Sys.println("");
                    Sys.println('Installing ${node.att.name}@git from ${node.att.url}');
                    Sys.println("");
                    Sys.command('haxelib git ${node.att.name} ${node.att.url} --always --skip-dependencies');
                case "cmd":
                    //kinda took this one from codename installer sorry i was lazy to understand that
					var lib = node.att.inLib;
					var dir = node.att.dir;
					var oldCwd = Sys.getCwd();
					if(lib != null) {
						var libPrefix = '.haxelib/$lib';
						if(FileSystem.exists(libPrefix)) {
							if(FileSystem.exists(libPrefix + '/.dev')) { // haxelib dev
								var devPath = File.getContent(libPrefix + '/.dev');
								if(!FileSystem.exists(devPath)) {
									Sys.println('Cannot find dev path $devPath for $lib');
									Sys.setCwd(oldCwd);
									continue;
								}
								Sys.setCwd(devPath + dir);
							} else if(FileSystem.exists(libPrefix + '/.current')) {
								var version = File.getContent(libPrefix + '/.current').replace(".", ",");
								if(!FileSystem.exists(libPrefix + '/$version')) {
									Sys.println('Cannot find version $version of $lib');
									Sys.setCwd(oldCwd);
									continue;
								}
								Sys.setCwd(libPrefix + '/$version' + '/$dir');
							} else {
								Sys.println('Cannot find .dev or .current file in $libPrefix');
								Sys.setCwd(oldCwd);
								continue;
							}
						}
					}
					Sys.command(node.att.cmd.replace("$PLATFORM", platform));
					Sys.setCwd(oldCwd);
            }
        }

        Sys.println("");
        Sys.println('Finished installing all libs!');
	}
}
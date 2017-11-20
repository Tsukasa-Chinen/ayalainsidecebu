// Require
var gulp = require("gulp");
var autoprefix = require("gulp-autoprefixer");
var browser = require("browser-sync"); 

// HTML Auto Reload
gulp.task('html', function() {
    gulp.src(['./src/**/*html'])
		.pipe(browser.reload({stream:true})
	)
});

// CSS Auto Reload
gulp.task('css', function() {
    gulp.src(['./src/**/*css'])
		.pipe(browser.reload({stream:true})
	)
});

// javascript Auto Reload
gulp.task('js', function() {
    gulp.src(['./src/**/*js'])
		.pipe(browser.reload({stream:true})
	)
});


// Local server Start
gulp.task("server", function(){
    browser({
        server: {
            baseDir: 'src/'
        }
    });
});

// Defoult Task
gulp.task('default', ['server'], function(){
	gulp.watch(['src/**/*html'], ['html']);
	gulp.watch(['src/**/*css'], ['css']);
	gulp.watch(['src/**/*js'], ['js']);
});


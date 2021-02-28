<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'fermelin' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql:3306' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

//edition needed

define( 'WP_HOME', 'http://192.168.99.123:5050/' );
define( 'WP_SITEURL', 'http://192.168.99.123:5050/' );
define('FS_METHOD', 'direct');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */

define('AUTH_KEY',         'iZ|h_nr{*+R|m|DX0AfFGn_4hNeTS,{)TItN5E5H.ju=yrg,0);4+-s*wvE*lbsb');
define('SECURE_AUTH_KEY',  'Q2s|!OwZ}~_0Rm<SQm8]F6E3FsX]#]o  5oeIQ|n*[hO/]}#M-y$>|7A&rK9UkdN');
define('LOGGED_IN_KEY',    '?a/X5ib%]Vv;fIuZ#^m4V|cE-va3r`9-6QzH{Ba-}L5C&!(1[|:E-|_mL<q9!SG%');
define('NONCE_KEY',        'S;b_?,&*%N@bv|A6J`h7)nq@?3n&bzoq:dP0N|l #.Tdes#1%|z;4k0;r{$G8+bc');
define('AUTH_SALT',        'C-Z/m#Vzak^6MjXg79mZm[&$]dXhYMHK/YjONKp,?aF;4DcJ`G+DA5&0{FxS6g>G');
define('SECURE_AUTH_SALT', 'iLQq~U&~_RxqNd?7QZ#R>]~qttG@4U@9Ff-WAXZ}xA=j5l4!IDm{,|rM2ncq%WnL');
define('LOGGED_IN_SALT',   '#S6FN*!aIOC*-/w`f,P$*GxLS.<=iYB1hw*@3HXjCFAN@&(qb;7mBo]Wuf;oB[U>');
define('NONCE_SALT',       'Be-_]JO+:|fXej,_HG|.fbvvm.E]Vb-+*6hqM.|IMB/}mZ+p)CGb{rr|<+3IRIwY');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
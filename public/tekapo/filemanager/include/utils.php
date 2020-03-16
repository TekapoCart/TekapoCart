<?php

if ($_SESSION["verify"] != "RESPONSIVEfilemanager") {
    die('forbiden');
}

function deleteDir($dir)
{
    if (!file_exists($dir)) {
        return true;
    }
    if (!is_dir($dir)) {

        // suzy: 2018-08-18 同時刪掉 GCP Cloud Storage 的圖片
        // return unlink($dir);
        $result = unlink($dir);
        if ($result && file_exists(_GCP_KEY_) && strlen(_GCP_BUCKET_) > 0) {
            $storage = new Google\Cloud\Storage\StorageClient(['keyFilePath' => _GCP_KEY_]);
            $bucket = $storage->bucket(_GCP_BUCKET_);
            $object = $bucket->object(str_replace(_PS_ROOT_DIR_ . '/', '', $dir));
            if ($object->exists()) {
                $object->delete();
            }
        }
        return $result;
    }
    foreach (scandir($dir, SCANDIR_SORT_NONE) as $item) {
        if ($item == '.' || $item == '..') {
            continue;
        }
        if (!deleteDir($dir.DIRECTORY_SEPARATOR.$item)) {
            return false;
        }
    }

    return rmdir($dir);
}

function duplicate_file($old_path, $name)
{
    if (file_exists($old_path)) {
        $info=pathinfo($old_path);
        $new_path=$info['dirname']."/".$name.".".$info['extension'];
        if (file_exists($new_path)) {
            return false;
        }

        // suzy: 2018-08-18 同時複製 GCP Cloud Storage 的圖片
        // return copy($old_path, $new_path);
        $result = copy($old_path, $new_path);
        if ($result && file_exists(_GCP_KEY_) && strlen(_GCP_BUCKET_) > 0) {
            $storage = new Google\Cloud\Storage\StorageClient(['keyFilePath' => _GCP_KEY_]);
            $bucket = $storage->bucket(_GCP_BUCKET_);
            $object = $bucket->object(str_replace(_PS_ROOT_DIR_ . '/', '', $old_path));
            if ($object->exists()) {
                $object->copy($new_path, ['name' => str_replace(_PS_ROOT_DIR_ . '/', '', $new_path)]);
            }

        }
        return $result;
    }
}

function rename_file($old_path, $name, $transliteration)
{
    $name=fix_filename($name, $transliteration);
    if (file_exists($old_path)) {
        $info=pathinfo($old_path);
        $new_path=$info['dirname']."/".$name.".".$info['extension'];
        if (file_exists($new_path)) {
            return false;
        }

        // suzy: 2018-08-18 同時 rename GCP Cloud Storage 的圖片
        // return rename($old_path, $new_path);
        $result = rename($old_path, $new_path);
        if ($result && file_exists(_GCP_KEY_) && strlen(_GCP_BUCKET_) > 0) {
            $storage = new Google\Cloud\Storage\StorageClient(['keyFilePath' => _GCP_KEY_]);
            $bucket = $storage->bucket(_GCP_BUCKET_);
            $object = $bucket->object(str_replace(_PS_ROOT_DIR_ . '/', '', $old_path));
            if ($object->exists()) {
                $object->copy(_GCP_BUCKET_, ['name' => str_replace(_PS_ROOT_DIR_ . '/', '', $new_path)]);
                $object->delete();
            }

        }
        return $result;
    }
}

function rename_folder($old_path, $name, $transliteration)
{
    $name=fix_filename($name, $transliteration);
    if (file_exists($old_path)) {
        $new_path=fix_dirname($old_path)."/".$name;
        if (file_exists($new_path)) {
            return false;
        }

        // suzy: 2018-08-18 同時 rename GCP Cloud Storage 的 folder
        // return rename($old_path, $new_path);
        $result = rename($old_path, $new_path);
        if ($result && file_exists(_GCP_KEY_) && strlen(_GCP_BUCKET_) > 0) {
            $storage = new Google\Cloud\Storage\StorageClient(['keyFilePath' => _GCP_KEY_]);
            $bucket = $storage->bucket(_GCP_BUCKET_);
            $object = $bucket->object(str_replace(_PS_ROOT_DIR_ . '/', '', $old_path));
            if ($object->exists()) {
                $object->copy($new_path, ['name' => str_replace(_PS_ROOT_DIR_ . '/', '', $new_path)]);
                $object->delete();
            }
        }
        return $result;
    }
}

function create_img_gd($imgfile, $imgthumb, $newwidth, $newheight="")
{
    if (image_check_memory_usage($imgfile, $newwidth, $newheight)) {
        require_once 'php_image_magician.php';
        $magicianObj = new imageLib($imgfile);
        $magicianObj -> resizeImage($newwidth, $newheight, 'crop');
        $magicianObj -> saveImage($imgthumb, 80);

        return true;
    }

    return false;
}

function create_img($imgfile, $imgthumb, $newwidth, $newheight="")
{
    if (image_check_memory_usage($imgfile, $newwidth, $newheight)) {
        require_once 'php_image_magician.php';
        $magicianObj = new imageLib($imgfile);
        $magicianObj -> resizeImage($newwidth, $newheight, 'auto');
        $magicianObj -> saveImage($imgthumb, 80);

        // suzy: 2018-08-12 上傳圖片同時傳到 GCP Cloud Storage
        if (file_exists(_GCP_KEY_) && strlen(_GCP_BUCKET_) > 0) {
            $storage = new StorageClient(['keyFilePath' => _GCP_KEY_]);
            $bucket = $storage->bucket(_GCP_BUCKET_);
            $file = fopen($imgthumb, 'r');
            $bucket->upload($file, [
                'name' => str_replace(_PS_ROOT_DIR_ . '/', '', $imgthumb),
                'metadata' => [
                    'Cache-Control' => 'public, max-age=604800',
                ]
            ]);
        }

        return true;
    } else {
        return false;
    }
}

function makeSize($size)
{
    $units = array('B','KB','MB','GB','TB');
    $u = 0;
    while ((round($size / 1024) > 0) && ($u < 4)) {
        $size = $size / 1024;
        $u++;
    }

    return number_format($size, 0) . " " . $units[$u];
}

function foldersize($path)
{
    $total_size = 0;
    $files = scandir($path, SCANDIR_SORT_NONE);
    $cleanPath = rtrim($path, '/'). '/';

    foreach ($files as $t) {
        if ($t != "." && $t != "..") {
            $currentFile = $cleanPath . $t;
            if (is_dir($currentFile)) {
                $size = foldersize($currentFile);
                $total_size += $size;
            } else {
                $size = filesize($currentFile);
                $total_size += $size;
            }
        }
    }

    return $total_size;
}

function create_folder($path=false, $path_thumbs=false)
{
    $oldumask = umask(0);
    if ($path && !file_exists($path)) {
        // suzy: 2018-09-22 0777 改 0755
        // mkdir($path, 0777, true);
        mkdir($path, 0755, true);
    } // or even 01777 so you get the sticky bit set
    if ($path_thumbs && !file_exists($path_thumbs)) {
        // mkdir($path_thumbs, 0777, true) || die("$path_thumbs cannot be found");
        mkdir($path_thumbs, 0755, true) || die("$path_thumbs cannot be found");
    } // or even 01777 so you get the sticky bit set
    umask($oldumask);
}

function check_files_extensions_on_path($path, $ext)
{
    if (!is_dir($path)) {
        $fileinfo = pathinfo($path);
        if (function_exists('mb_strtolower')) {
            if (!in_array(mb_strtolower($fileinfo['extension']), $ext)) {
                // suzy: 2018-08-18 GCP Cloud Storage
                // unlink($path);
                $result = unlink($path);
                if ($result && file_exists(_GCP_KEY_) && strlen(_GCP_BUCKET_) > 0) {
                    $storage = new Google\Cloud\Storage\StorageClient(['keyFilePath' => _GCP_KEY_]);
                    $bucket = $storage->bucket(_GCP_BUCKET_);
                    $object = $bucket->object(str_replace(_PS_ROOT_DIR_ . '/', '', $path));
                    if ($object->exists()) {
                        $object->delete();
                    }
                }
            } elseif (!in_array(Tools::strtolower($fileinfo['extension']), $ext)) {
                // suzy: 2018-08-18 GCP Cloud Storage
                // unlink($path);
                $result = unlink($path);
                if ($result && file_exists(_GCP_KEY_) && strlen(_GCP_BUCKET_) > 0) {
                    $storage = new Google\Cloud\Storage\StorageClient(['keyFilePath' => _GCP_KEY_]);
                    $bucket = $storage->bucket(_GCP_BUCKET_);
                    $object = $bucket->object(str_replace(_PS_ROOT_DIR_ . '/', '', $path));
                    if ($object->exists()) {
                        $object->delete();
                    }
                }
            }
        }
    } else {
        $files = scandir($path, SCANDIR_SORT_NONE);
        foreach ($files as $file) {
            check_files_extensions_on_path(trim($path, '/')."/".$file, $ext);
        }
    }
}

function check_files_extensions_on_phar($phar, &$files, $basepath, $ext)
{
    foreach ($phar as $file) {
        if ($file->isFile()) {
            if (function_exists('mb_strtolower')) {
                if (in_array(mb_strtolower($file->getExtension()), $ext)) {
                    $files[] = $basepath.$file->getFileName();
                } elseif (in_array(Tools::strtolower($file->getExtension()), $ext)) {
                    $files[] = $basepath.$file->getFileName();
                }
            }
        } elseif ($file->isDir()) {
            $iterator = new DirectoryIterator($file);
            check_files_extensions_on_phar($iterator, $files, $basepath.$file->getFileName().'/', $ext);
        }
    }
}

function fix_filename($str, $transliteration)
{
    if ($transliteration) {
        if (function_exists('transliterator_transliterate')) {
            $str = transliterator_transliterate('Accents-Any', $str);
        } else {
            $str = iconv('UTF-8', 'ASCII//TRANSLIT//IGNORE', $str);
        }

        $str = preg_replace("/[^a-zA-Z0-9\.\[\]_| -]/", '', $str);
    }

    $str=str_replace(array('"', "'", "/", "\\"), "", $str);
    $str=strip_tags($str);

    // Empty or incorrectly transliterated filename.
    // Here is a point: a good file UNKNOWN_LANGUAGE.jpg could become .jpg in previous code.
    // So we add that default 'file' name to fix that issue.
    if (strpos($str, '.') === 0) {
        $str = 'file'.$str;
    }

    return trim($str);
}

function fix_dirname($str)
{
    return str_replace('~', ' ', dirname(str_replace(' ', '~', $str)));
}

function fix_strtoupper($str)
{
    if (function_exists('mb_strtoupper')) {
        return mb_strtoupper($str);
    } else {
        return strtoupper($str);
    }
}

function fix_strtolower($str)
{
    if (function_exists('mb_strtoupper')) {
        return mb_strtolower($str);
    } else {
        return strtolower($str);
    }
}

function fix_path($path, $transliteration)
{
    $info=pathinfo($path);
    if (($s = strrpos($path, '/')) !== false) {
        $s++;
    }
    if (($e = strrpos($path, '.') - $s) !== strlen($info['filename'])) {
        $info['filename'] = substr($path, $s, $e);
        $info['basename'] = substr($path, $s);
    }
    $tmp_path = $info['dirname'].DIRECTORY_SEPARATOR.$info['basename'];

    $str=fix_filename($info['filename'], $transliteration);
    if ($tmp_path!="") {
        return $tmp_path.DIRECTORY_SEPARATOR.$str;
    } else {
        return $str;
    }
}

function base_url()
{
    return sprintf(
    "%s://%s",
    isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off' ? 'https' : 'http',
    $_SERVER['HTTP_HOST']
  );
}

function config_loading($current_path, $fld)
{
    if (file_exists($current_path.$fld.".config")) {

        require_once $current_path.$fld.".config";

        return true;
    }
    echo "!!!!".$parent=fix_dirname($fld);
    if ($parent!="." && !empty($parent)) {
        config_loading($current_path, $parent);
    }

    return false;
}

function image_check_memory_usage($img, $max_breedte, $max_hoogte)
{
    if (file_exists($img)) {
        $K64 = 65536;    // number of bytes in 64K
    $memory_usage = memory_get_usage();
        $memory_limit = abs((int) (str_replace('M', '', ini_get('memory_limit'))*1024*1024));
        $image_properties = getimagesize($img);
        $image_width = $image_properties[0];
        $image_height = $image_properties[1];
        $image_bits = $image_properties['bits'];
        $image_memory_usage = $K64 + ($image_width * $image_height * ($image_bits)  * 2);
        $thumb_memory_usage = $K64 + ($max_breedte * $max_hoogte * ($image_bits) * 2);
        $memory_needed = (int) ($memory_usage + $image_memory_usage + $thumb_memory_usage);

        if ($memory_needed > $memory_limit) {
            ini_set('memory_limit', ((int) ($memory_needed/1024/1024)+5) . 'M');
            if (ini_get('memory_limit') == ((int) ($memory_needed/1024/1024)+5) . 'M') {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    } else {
        return false;
    }
}

function endsWith($haystack, $needle)
{
    return $needle === "" || substr($haystack, -strlen($needle)) === $needle;
}

function new_thumbnails_creation($targetPath, $targetFile, $name, $current_path, $relative_image_creation, $relative_path_from_current_pos, $relative_image_creation_name_to_prepend, $relative_image_creation_name_to_append, $relative_image_creation_width, $relative_image_creation_height, $fixed_image_creation, $fixed_path_from_filemanager, $fixed_image_creation_name_to_prepend, $fixed_image_creation_to_append, $fixed_image_creation_width, $fixed_image_creation_height)
{
    //create relative thumbs
    $all_ok=true;
    if ($relative_image_creation) {
        foreach ($relative_path_from_current_pos as $k=>$path) {
            if ($path!="" && $path[strlen($path)-1]!="/") {
                $path.="/";
            }
            if (!file_exists($targetPath.$path)) {
                create_folder($targetPath.$path, false);
            }
            $info=pathinfo($name);
            if (!endsWith($targetPath, $path)) {
                if (!create_img($targetFile, $targetPath.$path.$relative_image_creation_name_to_prepend[$k].$info['filename'].$relative_image_creation_name_to_append[$k].".".$info['extension'], $relative_image_creation_width[$k], $relative_image_creation_height[$k])) {
                    $all_ok=false;
                }
            }
        }
    }

    //create fixed thumbs
    if ($fixed_image_creation) {
        foreach ($fixed_path_from_filemanager as $k=>$path) {
            if ($path!="" && $path[strlen($path)-1]!="/") {
                $path.="/";
            }
            $base_dir=$path.substr_replace($targetPath, '', 0, strlen($current_path));
            if (!file_exists($base_dir)) {
                create_folder($base_dir, false);
            }
            $info=pathinfo($name);
            if (!create_img($targetFile, $base_dir.$fixed_image_creation_name_to_prepend[$k].$info['filename'].$fixed_image_creation_to_append[$k].".".$info['extension'], $fixed_image_creation_width[$k], $fixed_image_creation_height[$k])) {
                $all_ok=false;
            }
        }
    }

    return $all_ok;
}

/**
 * Get a file from a URL using whichever mechanism is enabled
 * @param string $url the url to get the file from
 * @return bool|string false or the file's string content
 */
function get_file_by_url($url)
{
    $data = false;

    if (function_exists('curl_version')) {
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_URL, $url);

        $data = curl_exec($ch);
        curl_close($ch);
    } elseif (in_array(ini_get('allow_url_fopen'), array('On', 'on', '1'))) {
        $data = file_get_contents($url);
    }

    return $data;
}

/**
 * @param string $sourcePath
 * @param array $paths List of paths to compare
 */
function stopIfSameDir($sourcePath, array $paths)
{
    foreach ($paths as $path) {
        if (realpath($sourcePath) === realpath($path)) {
            die('wrong_path');
        }
    }
}

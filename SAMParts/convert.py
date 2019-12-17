from PIL import Image
from Scientific.Geometry import Vector
from numpy import arctan2, sqrt
from numpy import pi
from Scientific.Geometry.Transformation import Rotation
from optparse import OptionParser

#rotation vector for the picture
angle = Vector(0,0,0)

#coordinates of picture center
start_pos = Vector(-760.0, 1900.0, 60.0)

#crop mode
CROP = 1

#func type
TYPE = 0

#draw distance
DISTANCE = 0

#distance between objects
M_WS_0 = 5.875
M_HS_0 = 5.075
M_WS_1 = 3.18
M_HS_1 = 3.48
M_WS_2 = 1.48
M_HS_2 = 1.48
M_WS_3 = 0.5
M_HS_3 = 0.5


#object to use
M_OID_0 = 19464
M_OID_1 = 19372
M_OID_2 = 18887
M_OID_3 = 2814

#defaults
M_WP = 15
M_HP = 15
M_WS = M_WS_0
M_HS = M_HS_0
M_OID = M_OID_0

#name of the picture file
picture_name = 'dash.png'

#name of the output file
out_name = 'dash.txt'

def ParseObject (out, block):
    out.write("__temp_string__ = \"\";\n");
    xsize, ysize = block[0].size
    string = ""
    for y in xrange (0, ysize):
        out.write("strcat(__temp_string__, \"")
        for x in xrange (0, xsize):
            string_new = GetHexPix(block[0], x, y)
            if string_new != None:
                if string_new != string:
                    out.write("{%s}g" % string_new)
                else:
                    out.write("g")
                string = string_new
        out.write("\\n\", 2048);\n")
    angle = block[1][1]
    pos = block[1][0]
    add_rot = 0.0
    add_rotx = 0.0
    if M_OID == 2814:
        add_rot = - 94.65
    if M_OID == 18887:
        add_rotx = 90
        add_rot = 90
    if TYPE == 0:
        out.write("__oid__ = CreateObject(%d, %02f + __sX__, %02f + __sY__, %02f + __sZ__, %02f + %02f, %02f + %02f, 180 + %02f, %d);\n" % (M_OID, pos[0], pos[1], pos[2], add_rotx, angle[0], add_rot, angle[1], angle[2], DISTANCE))
        out.write("SetObjectMaterialText(__oid__, __temp_string__, 0, OBJECT_MATERIAL_SIZE_512x512, \"Webdings\", 35, 0, 0, 0, 0);\n");
    else:
        out.write("__oid__ = CreateDynamicObject(%d, %02f + __sX__, %02f + __sY__, %02f + __sZ__, %02f + %02f, %02f + %02f, 180 + %02f, -1, -1, -1, %d, %d);\n" % (M_OID, pos[0], pos[1], pos[2], add_rotx, angle[0], add_rot, angle[1], angle[2], DISTANCE, DISTANCE))
        out.write("SetDynamicObjectMaterialText(__oid__, 0, __temp_string__, OBJECT_MATERIAL_SIZE_512x512, \"Webdings\", 35, 0, 0, 0, 0);\n");
def LoadImageFromFile (filename):
    f = Image.open(filename)
    f.load ()
    return f
    
def GetCrop15 (image, w, h):
    xsize, ysize = image.size
    box = (M_WP*w, M_HP*h, min(M_WP*(w+1), xsize), min(M_HP*(h+1), ysize))
    newimage = image.crop(box)
    return (newimage, (w, h))
    
def Resize15 (image):
    xsize, ysize = image.size
    kx = M_WS/M_HS
    if kx < 1:
        nysize = int(ysize*M_HS/M_WS)
        image = image.resize((xsize, nysize), Image.ANTIALIAS)
        ysize = nysize
    else:
        nxsize = int(xsize*M_WS/M_HS)
        image = image.resize((nxsize, ysize), Image.ANTIALIAS)
        xsize = nxsize
    if CROP == 1:
        kw = int(xsize / M_WP)
        kh = int(ysize / M_HP)
        newimage = image.crop((0, 0, kw*M_WP, kh*M_HP))
    if CROP ==  2:
        kw = int(xsize / M_WP)
        kh = int(ysize / M_HP)
        newimage = image.resize((kw*M_WP, kh*M_HP), Image.ANTIALIAS)
    if CROP == 0:
        newimage = image
    return newimage
    
def GetHexPix (image, x, y):
    xsize, ysize = image.size
    if x < xsize and y < ysize:
        pix = image.getpixel((x,y))
        numpix = pix[0]*256*256 + pix[1]*256 + pix[2]
        hexpix = format(numpix, '06x')
        return hexpix
    else:
        return None

def main ():
    usage  = "SA:MP Art generator v0.3 by DialUp\nUsage: %prog [options]"
    parser = OptionParser (usage = usage)
    parser.add_option (
        "-i",
        default = None,
        action  = "store",
        type    = "string",
        dest    = "input_image",
        help    = "input image for conversion, for example, C:\\test\\1.png"
    )
    parser.add_option (
        "-o",
        default = None,
        action  = "store",
        type    = "string",
        dest    = "output_file",
        help    = "output file with PAWN code, for example, output.inc"
    )

    # do a full report generation by default:
    parser.set_defaults(mode = 0)

    # partial generation is done if some flags are specified:

    parser.add_option (
        "-m",
        default = 0,
        action  = "store",
        type   = "int",
        dest    = "mode",
        help    = "result size: 0 = very big, 1 = big, 2 = medium, 3 = small"
    )

    parser.add_option (
        "-s",
        default = "-760.0 1900.0 60.0",
        action  = "store",
        type   = "string",
        dest    = "position",
        help    = "picture centre position, for example, \"-760.0 1900.0 60.0\""
    )
    
    parser.add_option (
        "-r",
        default = "0 0 0",
        action  = "store",
        type    = "string",
        dest    = "rotation",
        help    = "rotation of the result picture, for example, \"0.0 0.0 90.0\""
    )
    
    parser.add_option (
        "-c",
        default = 1,
        action  = "store",
        type    = "int",
        dest    = "crop",
        help    = "0 = don't modify picture, 1 = crop, 2 = resize (to prevent half-filled objects)"
    )
    
    parser.add_option (
        "-t",
        default = 0,
        action  = "store",
        type    = "int",
        dest    = "type",
        help    = "0 = CreateObject, 1 = CreateDynamicObject"
    )
    
    parser.add_option (
        "-d",
        default = 300,
        action  = "store",
        type    = "int",
        dest    = "distance",
        help    = "draw distance"
    )

    (options, args) = parser.parse_args ()

    if options.input_image == None or options.output_file == None:
        parser.error("input picture file and output file should be specified")
    global M_WP, M_HP, M_WS, M_HS, M_OID, TYPE, DISTANCE
    if options.distance != None:
        DISTANCE = options.distance
    if options.mode == 1:
        M_WS = M_WS_1
        M_HS = M_HS_1
        M_OID = M_OID_1
        print "mode 1"
    if options.mode == 2:
        M_WS = M_WS_2
        M_HS = M_HS_2
        M_OID = M_OID_2
        print "mode 2"
    if options.mode == 3:
        M_WS = M_WS_3
        M_HS = M_HS_3
        M_OID = M_OID_3
        print "mode 3"
    if options.type == 1:
        TYPE = 1
    pos_vec = [float(x) for x in options.position.split()]
    pos_rot = [float(x) for x in options.rotation.split()]
    if (len(pos_vec) != 3 or len(pos_rot) != 3):
        parser.error("bad position or rotation parameters! use -help")
    global angle, start_pos
    if options.crop >= 0 and options.crop <3:
        global CROP
        CROP = options.crop
    angle = Vector(pos_rot[0], pos_rot[1], pos_rot[2])
    start_pos = Vector(pos_vec[0], pos_vec[1], pos_vec[2])
    dash = LoadImageFromFile(options.input_image)
    dash = Resize15(dash)
    xsize, ysize = dash.size
    blockx = int(float(xsize) / M_WP + 0.999)
    blocky = int(float(ysize) / M_HP + 0.999)
    dash_blocks = []
    for x in xrange (0, blockx):
        for y in xrange (0, blocky): 
            curblock = GetCrop15(dash, x, y)
            dash_blocks.append(curblock)

    Rot_z = Rotation(Vector(0,0,1), angle[2]*pi / 180.0)
    Rot_y = Rotation(Vector(0,1,0), angle[1]*pi / 180.0)
    Rot_x = Rotation(Vector(1,0,0), angle[0]*pi / 180.0)

    up_vector = Rot_z(Rot_y(Rot_x(Vector(0,0,1)))).normal()
    right_vector = Rot_z(Rot_y(Rot_x(Vector(0,1,0)))).normal()

    start_x = blockx / 2
    start_y = blocky / 2
    res_blocks = []

    for block in dash_blocks:
        cur_x = block[1][0]
        cur_y = block[1][1]
        temp = (block[0],  ((cur_x - start_x)*M_WS*right_vector + (cur_y - start_y)*(-M_HS)*up_vector, angle)) 
        res_blocks.append(temp)
    out = open(options.output_file,  'w')
    out.write("//This art was made with DialUp's SAMP art tool\n")
    out.write("//Send your suggestions or questions to 15432@mail.ru\n")
    out.write("#if defined __SART__\n")
    out.write("#else\n")
    out.write("new __oid__;\nnew __temp_string__[2048];\n")
    out.write("new Float:__sX__, Float:__sY__,Float:__sZ__;\n")
    out.write("#endif\n")
    out.write("#define __SART__\n")
    out.write("__oid__ = 0;\n__sX__ = %02f; __sY__ = %02f; __sZ__ = %02f;\n" %(start_pos[0], start_pos[1], start_pos[2]))
    for block in res_blocks:
        ParseObject(out, block)
    out.close()
    print "Done! Now add the result include file into your gamemode!"

if __name__ == '__main__':
    main()
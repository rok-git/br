#import "Cocoa/Cocoa.h"
#import "CoreImage/CoreImage.h"
#import "Vision/Vision.h"


NSArray *detectBarcodes(CIImage *image)
{
    NSDictionary *options;

    VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCIImage: image options: options];
    VNDetectBarcodesRequest *request = [[VNDetectBarcodesRequest alloc] init];
    [handler performRequests: @[request] error: nil];

    return request.results;
}


int main(int argc, char *argv[])
{
    @autoreleasepool{
	NSFileHandle *inputFileHandle = [NSFileHandle fileHandleWithStandardInput];
	NSFileHandle *outputFileHandle = [NSFileHandle fileHandleWithStandardOutput];
	NSData *data = [inputFileHandle readDataToEndOfFile];

	CIImage *image = [CIImage imageWithData: data];
	if(!image)
	    return 1;

	NSArray *barcodes = detectBarcodes(image);
	if(!barcodes)
	    return 1;

	if(barcodes.count > 0){
            NSMutableSet *barcodeSet = [NSMutableSet set];
	    for(VNBarcodeObservation *barcode in barcodes){
		NSString *barcodeString = [[barcode payloadStringValue] stringByAppendingString: @"\n"];
                [barcodeSet addObject: barcodeString];
	    }
            for(NSString *barcodeString in barcodeSet){
                [outputFileHandle writeData: [barcodeString dataUsingEncoding:NSUTF8StringEncoding]];
            }
            return 0;
	} else {
            return 1;
        }
    }
}

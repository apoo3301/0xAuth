"use client"

import { Popover, PopoverTrigger, PopoverContent } from "@/components/ui/popover";
import { Button } from "@/components/ui/button";
import { useSDK } from "@metamask/sdk-react";
import { formatAddress } from "@/lib/format";
import { Wallet } from "lucide-react";

export function ConnectWallet() {
    const { sdk, connected, connecting, account } = useSDK();

    const connect = async () => {
        try {
            await sdk?.connect();
        } catch (error) {
            console.warn("no accounts found", error);
        }
    }

    const disconnect = async () => {
        if (sdk) {
            sdk.terminate();
        }
    }

    return (
        <div className="relative">
            {connected ? (
                <Popover>
                    <PopoverTrigger asChild>
                        <Button variant="outline" className="border-white text-white hover:bg-white hover:text-gray-900">
                            {formatAddress(account)}
                        </Button>
                    </PopoverTrigger>
                    <PopoverContent className="w-44 p-0">
                        <Button
                            variant="ghost"
                            className="w-full justify-start text-red-600 hover:text-red-700 hover:bg-gray-100"
                            onClick={disconnect}
                        >
                            Disconnect
                        </Button>
                    </PopoverContent>
                </Popover>
            ) : (
                <Button
                    disabled={connecting}
                    onClick={connect}
                    className="bg-white text-gray-900 hover:bg-gray-100"
                >
                    <Wallet className="mr-2 h-4 w-4" /> Connect Wallet
                </Button>
            )}
        </div>
    )
}
/**
 * Formats an Ethereum address to a human-readable format.
 * @param address The Ethereum address to format.
 * @param chars The number of characters to display at the start and end of the address.
 * @returns The formatted Ethereum address.
 */

export function formatAddress(address: string | undefined, char = 4): string {
    if (!address) return "";
    if (!/^0x[a-fA-f0-9]{40}$/.test(address)) {
        console.warn("invalid ethereum address format")
        return address;
    }

    return `${address.substring(0, char + 2)}...${address.substring(address.length - char)}`;
}